import 'package:bimber/models/alcohol.dart';
import 'package:bimber/models/register_account_data.dart';

abstract class AccountRepository {
  Future<bool> isLoggedIn();
  Future<bool> checkIfEmailExists(String email);

  Future<bool> login(String email, String password);
  Future<void> register(RegisterAccountData data);
  Future<void> logout();
}

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
  Future<void> register(RegisterAccountData data) {
    throw UnimplementedError();
  }

  @override
  Future<bool> login(String email, String password) {
    return Future.value(email == "kuba@gmail.com" && password == "12345678");
  }

  @override
  Future<void> logout() {
    // TODO: implement logut
    throw UnimplementedError();
  }
}
