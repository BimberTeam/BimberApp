import 'package:graphql_flutter/graphql_flutter.dart';

final register = gql(r'''
mutation Register(
  $input: RegisterAccountInput!
) {
  register(input: $input) {
    id
  }
}
''');

final login = gql(r'''
mutation Login($input: LoginInput!) {
  login(input: $input) {
    token
  }
}
''');

final editAccount = gql(r'''
mutation EditAccount(
  $input: UpdateAccountInput!
) {
  updateAccount(input: $input) {
    id
    name
    age
    favoriteAlcoholName
    favoriteAlcoholType
    description
    gender
    genderPreference
    alcoholPreference
    agePreferenceFrom
    agePreferenceTo
  }
}
''');
