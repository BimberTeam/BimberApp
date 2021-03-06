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
    $genderPreference: Gender,
    $alcoholPreference: AlcoholType!,
    $agePreferenceFrom: Int!,
    $agePreferenceTo: Int!,
    $latitude: Float!,
    $longitude: Float!
  ) {
  register(input: {
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
    latitude: $latitude,
    longitude: $longitude
  }) {
    id
  }
}
''');

final login = gql(r'''
mutation Login($email: String!, $password: String!) {
  login(input: {
    email: $email, 
    password: $password
  }) {
    token
  }
}
''');

final editAccount = gql(r'''
mutation EditAccount(
    $name: String,
    $age: Int,
    $favoriteAlcoholName: String,
    $favoriteAlcoholType: AlcoholType,
    $description: String,
    $gender: Gender,
    $genderPreference: Gender,
    $alcoholPreference: AlcoholType,
    $agePreferenceFrom: Int,
    $agePreferenceTo: Int,
) {
  updateAccount(input: {
    name: $name,
    age: $age,
    favoriteAlcoholName: $favoriteAlcoholName,
    favoriteAlcoholType: $favoriteAlcoholType,
    description: $description,
    gender: $gender,
    genderPreference: $genderPreference,
    alcoholPreference: $alcoholPreference,
    agePreferenceFrom: $agePreferenceFrom,
    agePreferenceTo: $agePreferenceTo,
  }) {
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

final deleteAccount = gql(r'''
mutation DeleteAccount {
  deleteAccount {
    message
    status
  }
}
''');

final updateLocation = gql(r'''
mutation UpdateLocation($latitude: Float, $longitude: Float) {
  updateLocation(input: {latitude: $latitude, longitude: $longitude}) {
    message
    status
  }
}
''');
