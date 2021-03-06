import 'dart:async';
import 'dart:io';
import 'package:bimber/models/account_data.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/resources/graphql_repositories/common.dart';
import 'package:bimber/resources/repositories/account_repository.dart';
import 'package:bimber/resources/services/image_service.dart';
import 'package:bimber/resources/services/token_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AccountRepository repository;
  RegisterBloc({@required this.repository}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterSaveData) {
      yield RegisterSavedData(data: event.data);
    }
    if (event is RegisterAccount) {
      try {
        yield RegisterLoading();
        final registered = await repository.register(event.data);
        yield RegisterSuccess(account: registered);

        final userId = registered.id;

        await repository.login(event.data.email, event.data.password);
        final token = await TokenService.getToken();
        final image = File(event.data.imagePath);

        try {
          await ImageService.uploadImage(
              userId: userId, token: token, image: image);
        } on ImageUploadException catch (e) {
          print("Failed to upload image: $e");
        }

        yield RegisterNavigateToLogin();
      } catch (e) {
        print(e);
        yield (e is GraphqlConnectionError
            ? RegisterServerNotResponding()
            : RegisterError(
                data: event.data,
                message:
                    "Nie udało się utworzyć konta, spróbuj później!"));
      }
    }
  }
}
