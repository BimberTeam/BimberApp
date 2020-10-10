import 'package:graphql_flutter/graphql_flutter.dart';

final register = gql(r'''
mutation Register(
  $name: String!,
  $email: String!,
  $password: String!,
  $imageUrl: String,
  $age: Int!,
  $latestLocation: Point,
  $favoriteAlcoholName: String!,
  $favoriteAlcoholType: AlcoholType!,
  $description: String!,
  $gender: Gender!,
  $genderPreference: Gender!,
  $alcoholPreference: AlcoholType!,
  $agePreferenceFrom: Int!,
  $agePreferenceTo: Int!,
) {
  register(
    name: $name,
    email: $email,
    password: $password,
    imageUrl: $imageUrl,
    age: $age,
    latestLocation: $latestLocation,
    favoriteAlcoholName: $favoriteAlcoholName,
    favoriteAlcoholType: $favoriteAlcoholType,
    description: $description,
    gender: $gender,
    genderPreference: $genderPreference,
    alcoholPreference: $alcoholPreference,
    agePreferenceFrom: $agePreferenceFrom,
    agePreferenceTo: $agePreferenceTo,
  ) {
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
