import 'package:bimber/models/chat_thumbnail.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ChatThumbnailExtension on ChatThumbnail {
  Future<bool> checkIfRead(String meId) async {
    if (lastMessage == null) return true;
    if (lastMessage.userId == meId) return true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(this.groupId);
    if (value != null) {
      DateTime lastRead = DateTime.parse(value);
      if (lastRead.isAfter(this.lastMessage.date)) return true;
    }
    return false;
  }

  markAsRead() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.groupId, DateTime.now().toIso8601String());
  }
}
