import 'package:graphql_flutter/graphql_flutter.dart';

final profile = gql(r'''
query Me {
  me {
    id
    email
    name
    description
    age
    gender
    favoriteAlcoholName
    favoriteAlcoholType
    genderPreference
    alcoholPreference
    agePreferenceFrom
    agePreferenceTo
  }
}
''');

final accountExists = gql(r'''
query AccountExists($email: String!) {
  accountExists(email: $email)
}
''');
