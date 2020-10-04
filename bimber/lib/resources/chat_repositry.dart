import 'package:bimber/models/chat.dart';
import 'package:bimber/ui/common/fixtures.dart';

abstract class ChatRepository {
  Future<List<Chat>> fetchChatList();
}

class MockChatRepository extends ChatRepository {
  @override
  Future<List<Chat>> fetchChatList() {
    return Future.value(Fixtures.getChatLists());
  }
}
