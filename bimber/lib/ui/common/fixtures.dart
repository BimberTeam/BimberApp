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
              latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
              latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
              latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
              latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
              latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
              latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
              latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
        latestLocation: Location(latitude: 50.44, longtitude: 56.78));
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
          latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
          latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
          latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
          latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
          latestLocation: Location(latitude: 50.44, longtitude: 56.78)),
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
          latestLocation: Location(latitude: 50.44, longtitude: 56.78))
    ];
  }

  static List<Group> getGroups() {
    return [getGroup("aadsa"), getGroup("bda")];
  }

  static List<ChatThumbnail> getChatThumbnailLists() {
    List<ChatThumbnail> chats = List.generate(
        6,
        (index) => ChatThumbnail(
            groupId: "aaa" + index.toString(),
            name: "Harnas, Tatra, Żubr, Perła, Kasztelan",
            lastMessage: ChatMessage(
                groupId: "aaa",
                date: DateTime.now(),
                message: "siema" + index.toString(),
                userId: "aaa")));
    chats.add(ChatThumbnail(
        groupId: "bdg",
        name: "Harnas, Tatra, Żubr, Perła, Kasztelan",
        lastMessage: null));
    return chats;
  }

  static String getRandomHarnasUrl(String userId) {
    final harnasUrls = [
      "https://wygraland.pl/wp-content/uploads/2017/02/harnas-1.jpg",
      "https://www.smolar.pl/sites/default/files/styles/details/public/harna6x6_1.jpg?itok=z9SKYmae",
      "https://baxu.pl/storage/posts/August2019/jvSRI1Qh0NWCsia6ORs0.jpg"
    ];
    int hash = userId.hashCode;
    return harnasUrls[hash % 1];
  }

  static List<ChatMessage> getChatMessage() {
    List<ChatMessage> messages = List.generate(
        6,
        (index) => ChatMessage(
            name: "harnas" + index.toString(),
            groupId: "aaa",
            date: DateTime.now().subtract(Duration(minutes: 5 * index * index)),
            message: "siema" + index.toString(),
            userId: "aaa"));
    messages.add(ChatMessage(
        name: "Jadwiga",
        groupId: "aaa",
        date: DateTime.now().subtract(Duration(minutes: 100)),
        message: "syna nie ma w domu, lipinki łużyckie",
        userId: "bbb"));
    messages.add(ChatMessage(
        name: "Hymel",
        groupId: "aaa",
        date: DateTime.now().subtract(Duration(minutes: 100)),
        message: "halko? tutaj hymel jadwiga straz nie gasi",
        userId: "id"));
    return messages;
  }
}
