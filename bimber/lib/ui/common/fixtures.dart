import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/alcohol_type.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/models/location.dart';
import 'package:bimber/models/chat_message.dart';
import 'package:bimber/models/user.dart';

class Fixtures {
  static Group getGroup(String id) {
    return Group(
        id: id,
        averageAge: 20,
        averageLocation: Location(latitude: 50.44, longtitude: 56.78),
        members: [
          User(
              id: 'aaa',
              name: "Harnas",
              email: null,
              gender: Gender.MALE,
              age: 18,
              description: "Harnas, piwo z gór",
              favoriteAlcoholName: "Harnas",
              favoriteAlcoholType: AlcoholType.BEER,
              genderPreference: Gender.MALE,
              agePreferenceFrom: 18,
              agePreferenceTo: 99,
              alcoholPreference: AlcoholType.BEER,
              imageUrl:
                  "https://wygraland.pl/wp-content/uploads/2017/02/harnas-1.jpg",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'bbb',
              name: "Harnas",
              email: null,
              gender: Gender.MALE,
              age: 22,
              description: "Harnas, piwo z gór",
              favoriteAlcoholName: "Harnas",
              favoriteAlcoholType: AlcoholType.BEER,
              genderPreference: Gender.MALE,
              agePreferenceFrom: 18,
              agePreferenceTo: 99,
              alcoholPreference: AlcoholType.BEER,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.png",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'ccc',
              name: "Harnas",
              email: null,
              gender: Gender.MALE,
              age: 22,
              description: "Harnas, piwo z gór",
              favoriteAlcoholName: "Harnas",
              favoriteAlcoholType: AlcoholType.BEER,
              genderPreference: Gender.MALE,
              agePreferenceFrom: 18,
              agePreferenceTo: 99,
              alcoholPreference: AlcoholType.BEER,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.pg",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'ddd',
              name: "Harnas",
              email: null,
              gender: Gender.MALE,
              age: 22,
              description: "Harnas, piwo z gór",
              favoriteAlcoholName: "Harnas",
              favoriteAlcoholType: AlcoholType.BEER,
              genderPreference: Gender.MALE,
              agePreferenceFrom: 18,
              agePreferenceTo: 99,
              alcoholPreference: AlcoholType.BEER,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'eee',
              name: "Harnas",
              email: null,
              gender: Gender.MALE,
              age: 22,
              description: "Harnas, piwo z gór",
              favoriteAlcoholName: "Harnas",
              favoriteAlcoholType: AlcoholType.BEER,
              genderPreference: Gender.MALE,
              agePreferenceFrom: 18,
              agePreferenceTo: 99,
              alcoholPreference: AlcoholType.BEER,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'fff',
              name: "Harnas",
              email: null,
              gender: Gender.MALE,
              age: 22,
              description: "Harnas, piwo z gór",
              favoriteAlcoholName: "Harnas",
              favoriteAlcoholType: AlcoholType.BEER,
              genderPreference: Gender.MALE,
              agePreferenceFrom: 18,
              agePreferenceTo: 99,
              alcoholPreference: AlcoholType.BEER,
              imageUrl:
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
              location: Location(latitude: 50.44, longtitude: 56.78),
              friends: null),
          User(
              id: 'ggg',
              name: "Harnas",
              email: null,
              gender: Gender.MALE,
              age: 22,
              description: "Harnas, piwo z gór",
              favoriteAlcoholName: "Harnas",
              favoriteAlcoholType: AlcoholType.BEER,
              genderPreference: Gender.MALE,
              agePreferenceFrom: 18,
              agePreferenceTo: 99,
              alcoholPreference: AlcoholType.BEER,
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
        gender: Gender.MALE,
        age: 18,
        description: "Harnas, piwo z gór",
        favoriteAlcoholName: "Harnas",
        favoriteAlcoholType: AlcoholType.BEER,
        genderPreference: Gender.MALE,
        agePreferenceFrom: 18,
        agePreferenceTo: 99,
        alcoholPreference: AlcoholType.BEER,
        imageUrl:
            "https://wygraland.pl/wp-content/uploads/2017/02/harnas-1.jpg",
        location: Location(latitude: 50.44, longtitude: 56.78),
        friends: null);
  }

  static List<User> getUsersList() {
    return [
      User(
          id: 'aaa',
          name: "Harnas",
          email: null,
          gender: Gender.MALE,
          age: 18,
          description: "Harnas, piwo z gór",
          favoriteAlcoholName: "Harnas",
          favoriteAlcoholType: AlcoholType.BEER,
          genderPreference: Gender.MALE,
          agePreferenceFrom: 18,
          agePreferenceTo: 99,
          alcoholPreference: AlcoholType.BEER,
          imageUrl:
              "https://wygraland.pl/wp-content/uploads/2017/02/harnas-1.jpg",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'bbb',
          name: "Harnas",
          email: null,
          gender: Gender.MALE,
          age: 22,
          description: "Harnas, piwo z gór",
          favoriteAlcoholName: "Harnas",
          favoriteAlcoholType: AlcoholType.BEER,
          genderPreference: Gender.MALE,
          agePreferenceFrom: 18,
          agePreferenceTo: 99,
          alcoholPreference: AlcoholType.BEER,
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.png",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'ccc',
          name: "Harnas",
          email: null,
          gender: Gender.MALE,
          age: 22,
          description: "Harnas, piwo z gór",
          favoriteAlcoholName: "Harnas",
          favoriteAlcoholType: AlcoholType.BEER,
          genderPreference: Gender.MALE,
          agePreferenceFrom: 18,
          agePreferenceTo: 99,
          alcoholPreference: AlcoholType.BEER,
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/8/85/Harna%C5%9B_glass_bottle.pg",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'ddd',
          name: "Harnas",
          email: null,
          gender: Gender.MALE,
          age: 22,
          description: "Harnas, piwo z gór",
          favoriteAlcoholName: "Harnas",
          favoriteAlcoholType: AlcoholType.BEER,
          genderPreference: Gender.MALE,
          agePreferenceFrom: 18,
          agePreferenceTo: 99,
          alcoholPreference: AlcoholType.BEER,
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'eee',
          name: "Harnas",
          email: null,
          gender: Gender.MALE,
          age: 22,
          description: "Harnas, piwo z gór",
          favoriteAlcoholName: "Harnas",
          favoriteAlcoholType: AlcoholType.BEER,
          genderPreference: Gender.MALE,
          agePreferenceFrom: 18,
          agePreferenceTo: 99,
          alcoholPreference: AlcoholType.BEER,
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'fff',
          name: "Harnas",
          email: null,
          gender: Gender.MALE,
          age: 22,
          description: "Harnas, piwo z gór",
          favoriteAlcoholName: "Harnas",
          favoriteAlcoholType: AlcoholType.BEER,
          genderPreference: Gender.MALE,
          agePreferenceFrom: 18,
          agePreferenceTo: 99,
          alcoholPreference: AlcoholType.BEER,
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null),
      User(
          id: 'ggg',
          name: "Harnas",
          email: null,
          gender: Gender.MALE,
          age: 22,
          description: "Harnas, piwo z gór",
          favoriteAlcoholName: "Harnas",
          favoriteAlcoholType: AlcoholType.BEER,
          genderPreference: Gender.MALE,
          agePreferenceFrom: 18,
          agePreferenceTo: 99,
          alcoholPreference: AlcoholType.BEER,
          imageUrl:
              "https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Harna%C5%9B_can.png/215px-Harna%C5%9B_can.png",
          location: Location(latitude: 50.44, longtitude: 56.78),
          friends: null)
    ];
  }

  static List<Group> getGroups() {
    return [getGroup("aadsa"), getGroup("bda")];
  }

  static List<ChatThumbnail> getChatThumbnailLists() {
    List<ChatThumbnail> chats = List.generate(
        6,
        (index) => ChatThumbnail(
            id: "aaa",
            groupId: "aaa",
            avatarId: null,
            name: "Harnas, Tatra, Żubr, Perła, Kasztelan",
            lastMessage: ChatMessage(
                id: "aaa",
                groupId: "aaa",
                date: DateTime.now(),
                text: "siema" + index.toString(),
                sender: "aaa")));
    chats.add(ChatThumbnail(
        id: "aaa",
        groupId: "aaa",
        avatarId: null,
        name: "Harnas, Tatra, Żubr, Perła, Kasztelan",
        lastMessage: null));
    return chats;
  }

  static List<ChatMessage> getChatMessages() {
    List<ChatMessage> chats = List.generate(
        10,
            (index) => ChatMessage(
            id: "aaa",
            groupId: "aaa",
            text: "siemahasijdfna sakdfnakjf sdkfna asdfjna" + index.toString(),
            date: DateTime.now(),
            sender: "id" + index.toString()));
    return chats;
  }
}
