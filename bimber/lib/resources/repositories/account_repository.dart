import 'package:bimber/models/account_data.dart';
import 'package:bimber/models/register_account_data.dart';

abstract class AccountRepository {
  Future<bool> isLoggedIn();
  Future<bool> checkIfEmailExists(String email);

  Future<bool> login(String email, String password);
  Future<AccountData> register(RegisterAccountData data);
  Future<void> logout();
}