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
                id: "aaa",
                groupId: "aaa",
                date: DateTime.now(),
                text: "siema" + index.toString(),
                sender: "aaa")));
    chats.add(ChatThumbnail(
        groupId: "bdg",
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
            text: "siema" + index.toString(),
            date: DateTime.now().subtract(Duration(minutes: 70 * index)),
            sender: "id" + index.toString()));
    chats.sort((a, b) => b.date.compareTo(a.date));
    return chats;
  }

  static String getRandomHarnasUrl(String userId) {
    final harnasUrls = [
      "https://wygraland.pl/wp-content/uploads/2017/02/harnas-1.jpg",
    ];
    int hash = userId.hashCode;
    return harnasUrls[hash % 1];
  }
}
