import 'package:bimber/models/chat_message.dart';
import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/models/message.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';
import 'package:meta/meta.dart';

abstract class ChatRepository {
  Future<List<ChatThumbnail>> fetchChatThumbnails({bool fetchCache = false});

  Future<List<ChatMessage>> fetchChatMessages(
      {@required String groupId, int limit, DateTime lastDate});

  Future<Message> sendChatMessage(
      {@required String message, @required String groupId});

  Stream<QueryResult> newChatMessageStream({@required String groupId});
}
