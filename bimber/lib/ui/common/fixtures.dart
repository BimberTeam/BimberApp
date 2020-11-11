import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/group.dart';
import 'package:bimber/models/alcohol_type.dart';
import 'package:bimber/models/gender.dart';
import 'package:bimber/models/group_candidate.dart';
import 'package:bimber/models/location.dart';
import 'package:bimber/models/chat_message.dart';
import 'package:bimber/models/user.dart';

class Fixtures {
  static Group getGroup(String id) {
    return Group(
        id: id,
        averageAge: 20,
        averageLocation: Location(latitude: 50.44, longitude: 56.78),
        members: getUSAPresidents());
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
        latestLocation: Location(latitude: 50.44, longitude: 56.78));
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
          latestLocation: Location(latitude: 50.44, longitude: 56.78)),
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
          latestLocation: Location(latitude: 50.44, longitude: 56.78)),
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
          latestLocation: Location(latitude: 50.44, longitude: 56.78)),
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
          latestLocation: Location(latitude: 50.44, longitude: 56.78)),
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
          latestLocation: Location(latitude: 50.44, longitude: 56.78)),
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
          latestLocation: Location(latitude: 50.44, longitude: 56.78))
    ];
  }

  static List<User> getUSAPresidents() {
    return [
      User(
          id: 'fff',
          name: "Donald Trump",
          email: null,
          gender: Gender.MALE,
          age: 18,
          description: "Make america great again",
          favoriteAlcoholName: "Harnas",
          favoriteAlcoholType: AlcoholType.BEER,
          genderPreference: Gender.MALE,
          agePreferenceFrom: 18,
          agePreferenceTo: 99,
          alcoholPreference: AlcoholType.BEER,
          latestLocation: Location(latitude: 50.049683, longitude: 19.949544)),
      User(
          id: '2',
          name: "Joe Biden",
          email: null,
          gender: Gender.MALE,
          age: 22,
          description: "vote me",
          favoriteAlcoholName: "Harnas",
          favoriteAlcoholType: AlcoholType.BEER,
          genderPreference: Gender.MALE,
          agePreferenceFrom: 18,
          agePreferenceTo: 99,
          alcoholPreference: AlcoholType.BEER,
          latestLocation: Location(latitude: 50.041683, longitude: 19.949544)),
      User(
          id: 'aaa',
          name: "Barack Obama",
          email: null,
          gender: Gender.MALE,
          age: 22,
          description: "just chilling",
          favoriteAlcoholName: "Harnas",
          favoriteAlcoholType: AlcoholType.BEER,
          genderPreference: Gender.MALE,
          agePreferenceFrom: 18,
          agePreferenceTo: 99,
          alcoholPreference: AlcoholType.BEER,
          latestLocation: Location(latitude: 50.049683, longitude: 19.941544)),
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
                name: "Harnas",
                groupId: "aaa",
                date: DateTime.now().subtract(Duration(minutes: index * 15)),
                message: "siema" + index.toString(),
                userId: "aaa")));
    chats.add(ChatThumbnail(
        groupId: "bdg",
        name: "Harnas, Tatra, Żubr, Perła, Kasztelan",
        lastMessage: null));
    return chats;
  }

  static String getRandomPresidentImageUrl(String userId) {
    final urls = [
      "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Donald_Trump_official_portrait.jpg/1200px-Donald_Trump_official_portrait.jpg",
      "https://www.history.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTc2MzAyNDY4NjM0NzgwODQ1/joe-biden-gettyimages-1267438366.jpg",
      "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/President_Barack_Obama.jpg/1200px-President_Barack_Obama.jpg"
    ];
    int hash = userId.hashCode;
    return urls[hash % 3];
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

  static List<GroupCandidate> getGroupCandidates() {
    return getUSAPresidents()
        .map((user) => GroupCandidate(
            user: user, votesAgainst: 3, votesInFavour: 5, groupCount: 10))
        .toList();
  }
}
