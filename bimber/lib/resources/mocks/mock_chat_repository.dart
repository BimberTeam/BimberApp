import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/resources/chat_repositry.dart';
import 'package:bimber/ui/common/fixtures.dart';

class MockChatRepository extends ChatRepository {
  @override
  Future<List<ChatThumbnail>> fetchChatList() {
    return Future.delayed(Duration(seconds: 1), () => Fixtures.getChatLists());
  }
}