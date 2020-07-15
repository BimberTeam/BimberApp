import 'package:bimber/models/utils.dart';

abstract class AccountRepository{
  Future<bool> isLoggedIn();
  Future<bool> checkIfEmailExists(String email);
  Future<bool> login(String email, String password);
  Future<bool> createAccount(String email, String password, String imagePath, int age, Alcohol favouriteAlcoholType, String favouriteAlcohol, String name,
      String description, Gender genderPreferences, int agePreferences, Gender gender, Alcohol alcoholPreferences);
}

class MockAccountRepository extends AccountRepository{
  @override
  Future<bool> checkIfEmailExists(String email) {
     return Future.value(email == "kuba@gmail.com");
  }

  @override
  Future<bool> isLoggedIn() {
    return Future.value(false);
  }

  @override
  Future<bool> login(String email, String password) {
    return Future.value(email == "kuba@gmail.com" && password == "12345678");
  }

  @override
  Future<bool> createAccount(String email, String password, String imagePath, int age, Alcohol favouriteAlcoholType, String favouriteAlcohol, String name, String description, Gender genderPreferences, int agePreferences, Gender gender, Alcohol alcoholPreferences) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

}