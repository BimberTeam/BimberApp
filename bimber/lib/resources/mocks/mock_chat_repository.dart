import 'package:bimber/models/chat_thumbnail.dart';
import 'package:bimber/resources/repositories/chat_repositry.dart';
import 'package:bimber/ui/common/fixtures.dart';

class MockChatRepository extends ChatRepository {
  @override
  Future<List<ChatThumbnail>> fetchChatThumbnails({fetchCache = false}) {
    if (fetchCache) return Future.value(Fixtures.getChatThumbnailLists());
    return Future.delayed(
        Duration(seconds: 1), () => Fixtures.getChatThumbnailLists());
  }
}
