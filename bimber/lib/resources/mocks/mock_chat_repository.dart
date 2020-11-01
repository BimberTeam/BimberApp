import 'package:bimber/models/chat_message.dart';
import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/message.dart';
import 'package:bimber/resources/repositories/chat_repository.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:graphql/src/core/query_result.dart';

class MockChatRepository extends ChatRepository {
  @override
  Future<List<ChatThumbnail>> fetchChatThumbnails({fetchCache = false}) {
    if (fetchCache) return Future.value(Fixtures.getChatThumbnailLists());
    return Future.delayed(
        Duration(seconds: 1), () => Fixtures.getChatThumbnailLists());
  }

  @override
  Future<List<ChatMessage>> fetchChatMessages(
      {String groupId, int limit, DateTime lastDate}) {
    // TODO: implement fetchChatMessages
    throw UnimplementedError();
  }

  @override
  Stream<QueryResult> newChatMessageStream({String groupId}) {
    // TODO: implement newChatMessageStream
    throw UnimplementedError();
  }

  @override
  Future<Message> sendChatMessage({String message, String groupId}) {
    // TODO: implement sendChatMessage
    throw UnimplementedError();
  }
}
