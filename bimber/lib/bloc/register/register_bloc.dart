import 'dart:async';

import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/resources/account_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AccountRepository _repository;
  RegisterBloc({@required AccountRepository repository})
      : _repository = repository,
        super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterSaveData) {
      yield RegisterSavedData(data: event.data);
    }
    if (event is RegisterAccount) {
      // TODO: bind it with repository
      yield RegisterSuccess(data: event.data);
    }
  }
}
