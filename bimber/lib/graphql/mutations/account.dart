import 'package:graphql_flutter/graphql_flutter.dart';

final register = gql(r'''
mutation Register(
  $name: String!,
  $email: String!,
  $password: String!,
  $age: Int!,
  $favoriteAlcoholName: String!,
  $favoriteAlcoholType: AlcoholType!,
  $description: String!,
  $gender: Gender!,
  $genderPreference: Gender!,
  $alcoholPreference: AlcoholType!,
  $agePreferenceFrom: Int!,
  $agePreferenceTo: Int!,
) {
  register(user: {
    name: $name,
    email: $email,
    password: $password,
    age: $age,
    favoriteAlcoholName: $favoriteAlcoholName,
    favoriteAlcoholType: $favoriteAlcoholType,
    description: $description,
    gender: $gender,
    genderPreference: $genderPreference,
    alcoholPreference: $alcoholPreference,
    agePreferenceFrom: $agePreferenceFrom,
    agePreferenceTo: $agePreferenceTo,
    latestLocation: {longitude: 0, latitude: 0}
  }) {
    id
  }
}
''');

final login = gql(r'''
mutation Login($email: String!, $password: String!) {
  login(email: $email, password: $password) {
    token
  }
}
''');
