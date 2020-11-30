import 'dart:async';
import 'dart:io';

import 'package:bimber/models/account_data.dart';
import 'package:bimber/models/edit_account_data.dart';
import 'package:bimber/models/status.dart';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bimber/resources/services/image_service.dart';
import 'package:bimber/resources/services/token_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository repository;
  AccountBloc({@required this.repository}) : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(
    AccountEvent event,
  ) async* {
    if (event is FetchAccount) {
      yield* _mapFetchAccountEvent(event);
    }
    if (event is EditAccount) {
      yield* _mapEditAccountEvent(event);
    }
    if (event is DeleteAccount) {
      yield* _mapDeleteAccountEvent();
    }
  }

  Stream<AccountState> _mapFetchAccountEvent(FetchAccount event) async* {
    yield AccountLoading();

    try {
      final me = await repository.fetchMe(useCache: event.useCache);
      yield AccountFetched(account: me);
    } catch (e) {
      yield (e is GraphqlConnectionError
          ? AccountServerNotResponding()
          : AccountError(
              message:
                  "Wystąpił problem podczas ładownia profilu, spróbuj ponownie później!"));
    }
  }

  Stream<AccountState> _mapDeleteAccountEvent() async* {
    yield AccountLoading();
    try {
      final message = await repository.deleteAccount();
      if (message.status == Status.OK)
        yield AccountDeleted();
      else
        yield EditAccountError(message: message.message);
    } catch (e) {
      yield (e is GraphqlConnectionError
          ? AccountServerNotResponding()
          : EditAccountError(
              message:
                  "Wystąpił błąd podczas aktualizacji zdjęcia! Spróbuj później..."));
    }
  }

  Stream<AccountState> _mapEditAccountEvent(EditAccount event) async* {
    yield EditAccountLoading();

    try {
      if (event.data.imagePath != null) {
        final userId = event.data.id;
        final token = await TokenService.getToken();
        final image = File(event.data.imagePath);
        await ImageService.uploadImage(
            userId: userId, token: token, image: image);
      }
      await repository.editAccount(event.data);

      yield EditAccountSuccess();
    } on ImageUploadException {
      yield EditAccountError(
          message:
              "Wystąpił błąd podczas aktualizacji zdjęcia! Spróbuj później...");
    } catch (e) {
      yield (e is GraphqlConnectionError
          ? AccountServerNotResponding()
          : EditAccountError(
              message:
                  "Wystąpił problem przy edycji konta, spróbuj ponownie później!"));
    }
  }
}
