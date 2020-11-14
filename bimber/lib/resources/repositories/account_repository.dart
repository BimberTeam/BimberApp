import 'package:bimber/models/account_data.dart';
import 'package:bimber/models/edit_account_data.dart';
import 'package:bimber/models/message.dart';
import 'package:bimber/models/register_account_data.dart';

abstract class AccountRepository {
  Future<bool> isLoggedIn();
  Future<bool> checkIfEmailExists(String email);
  Future<bool> login(String email, String password);
  Future<void> logout();
  Future<AccountData> register(RegisterAccountData data);
  Future<void> editAccount(EditAccountData data);
  Future<AccountData> fetchMe({bool useCache});
  Future<void> updateLocation();
  Future<Message> deleteAccount();
}
