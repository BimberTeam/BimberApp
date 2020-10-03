import 'package:bimber/models/group.dart';
import 'package:bimber/models/age_preference.dart';
import 'package:bimber/models/alcohol.dart';
import 'package:bimber/models/alcohol_type.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/models/location.dart';
import 'package:bimber/models/user.dart';

class Fixtures {
  static Group getGroup() {
    return Group(
        id: 'grupa',
        averageAge: 20,
        averageLocation: Location(latitude: 50.44, longtitude: 56.78),
        members: [
          User(
              id: 'aaa',
              name: "Harnas",
              email: null,
              gender: Gender.Male,
              age: 18,
              description: "Harnas, piwo z gór",
              favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
              genderPreference: Gender.Male,
              agePreference: AgePreference(from: 18, to: 99),
              alcoholPreference: AlcoholType.Beer,
              imageUrl:
                  "https://wygraland.pl/wp-content/uploads/2017/02/harnas-1.jpg",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'bbb',
              name: "Harnas",
              email: null,
              gender: Gender.Male,
              age: 22,
              description: "Harnas, piwo z gór",
              favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
              genderPreference: Gender.Male,
              agePreference: AgePreference(from: 18, to: 99),
              alcoholPreference: AlcoholType.Beer,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.png",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'ccc',
              name: "Harnas",
              email: null,
              gender: Gender.Male,
              age: 22,
              description: "Harnas, piwo z gór",
              favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
              genderPreference: Gender.Male,
              agePreference: AgePreference(from: 18, to: 99),
              alcoholPreference: AlcoholType.Beer,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.pg",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'ddd',
              name: "Harnas",
              email: null,
              gender: Gender.Male,
              age: 22,
              description: "Harnas, piwo z gór",
              favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
              genderPreference: Gender.Male,
              agePreference: AgePreference(from: 18, to: 99),
              alcoholPreference: AlcoholType.Beer,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'eee',
              name: "Harnas",
              email: null,
              gender: Gender.Male,
              age: 22,
              description: "Harnas, piwo z gór",
              favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
              genderPreference: Gender.Male,
              agePreference: AgePreference(from: 18, to: 99),
              alcoholPreference: AlcoholType.Beer,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'fff',
              name: "Harnas",
              email: null,
              gender: Gender.Male,
              age: 22,
              description: "Harnas, piwo z gór",
              favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
              genderPreference: Gender.Male,
              agePreference: AgePreference(from: 18, to: 99),
              alcoholPreference: AlcoholType.Beer,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'ggg',
              name: "Harnas",
              email: null,
              gender: Gender.Male,
              age: 22,
              description: "Harnas, piwo z gór",
              favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
              genderPreference: Gender.Male,
              agePreference: AgePreference(from: 18, to: 99),
              alcoholPreference: AlcoholType.Beer,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
        ]);
  }

  static User getUser() {
    return User(
        id: 'user',
        name: "Harnas",
        email: null,
        gender: Gender.Male,
        age: 18,
        description: "Harnas, piwo z gór",
        favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
        genderPreference: Gender.Male,
        agePreference: AgePreference(from: 18, to: 99),
        alcoholPreference: AlcoholType.Beer,
        imageUrl:
            "https://wygraland.pl/wp-content/uploads/2017/02/harnas-1.jpg",
        location: Location(latitude: 50.44, longtitude: 56.78),
        friends: null);
  }

  static List<User> getUsersList(){
    return [User(
        id: 'aaa',
        name: "Harnas",
        email: null,
        gender: Gender.Male,
        age: 18,
        description: "Harnas, piwo z gór",
        favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
        genderPreference: Gender.Male,
        agePreference: AgePreference(from: 18, to: 99),
        alcoholPreference: AlcoholType.Beer,
        imageUrl:
        "https://wygraland.pl/wp-content/uploads/2017/02/harnas-1.jpg",
        location: Location(latitude: 50.44, longtitude: 56.78),
        friends: null),
      User(
          id: 'bbb',
          name: "Harnas",
          email: null,
          gender: Gender.Male,
          age: 22,
          description: "Harnas, piwo z gór",
          favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
          genderPreference: Gender.Male,
          agePreference: AgePreference(from: 18, to: 99),
          alcoholPreference: AlcoholType.Beer,
          imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.png",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'ccc',
          name: "Harnas",
          email: null,
          gender: Gender.Male,
          age: 22,
          description: "Harnas, piwo z gór",
          favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
          genderPreference: Gender.Male,
          agePreference: AgePreference(from: 18, to: 99),
          alcoholPreference: AlcoholType.Beer,
          imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.pg",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'ddd',
          name: "Harnas",
          email: null,
          gender: Gender.Male,
          age: 22,
          description: "Harnas, piwo z gór",
          favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
          genderPreference: Gender.Male,
          agePreference: AgePreference(from: 18, to: 99),
          alcoholPreference: AlcoholType.Beer,
          imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'eee',
          name: "Harnas",
          email: null,
          gender: Gender.Male,
          age: 22,
          description: "Harnas, piwo z gór",
          favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
          genderPreference: Gender.Male,
          agePreference: AgePreference(from: 18, to: 99),
          alcoholPreference: AlcoholType.Beer,
          imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'fff',
          name: "Harnas",
          email: null,
          gender: Gender.Male,
          age: 22,
          description: "Harnas, piwo z gór",
          favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
          genderPreference: Gender.Male,
          agePreference: AgePreference(from: 18, to: 99),
          alcoholPreference: AlcoholType.Beer,
          imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'ggg',
          name: "Harnas",
          email: null,
          gender: Gender.Male,
          age: 22,
          description: "Harnas, piwo z gór",
          favouriteAlcohol: Alcohol(name: "Harnas", type: AlcoholType.Beer),
          genderPreference: Gender.Male,
          agePreference: AgePreference(from: 18, to: 99),
          alcoholPreference: AlcoholType.Beer,
          imageUrl:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null)];
  }
}
