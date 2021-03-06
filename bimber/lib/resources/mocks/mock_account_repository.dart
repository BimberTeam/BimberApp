import 'package:bimber/models/account_data.dart';
import 'package:bimber/models/edit_account_data.dart';
import 'package:bimber/models/message.dart';
import 'package:bimber/models/register_account_data.dart';
import 'package:bimber/models/status.dart';
import 'package:bimber/resources/repositories/account_repository.dart';

class MockAccountRepository extends AccountRepository {
  @override
  Future<bool> checkIfEmailExists(String email) {
    return Future.value(email == "kuba@gmail.com");
  }

  @override
  Future<bool> isLoggedIn() {
    return Future.value(false);
  }

  @override
  Future<AccountData> register(RegisterAccountData data) {
    throw UnimplementedError();
  }

  @override
  Future<void> login(String email, String password) {
    return Future.value(email == "kuba@gmail.com" && password == "12345678");
  }

  @override
  Future<void> logout() {
    // TODO: implement logut
    throw UnimplementedError();
  }

  @override
  Future<void> editAccount(EditAccountData data) {
    throw UnimplementedError();
  }

  @override
  Future<AccountData> fetchMe({bool useCache}) {
    throw UnimplementedError();
  }

  @override
  Future<Message> deleteAccount() {
    return Future.value(Message(status: Status.OK, message: "ok"));
  }

  @override
  Future<void> updateLocation() {
    // TODO: implement updateLocation
    throw UnimplementedError();
  }
}
