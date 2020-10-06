import 'package:bimber/models/chat_thumbnail.dart';

abstract class ChatRepository {
  Future<List<ChatThumbnail>> fetchChatList();
}

