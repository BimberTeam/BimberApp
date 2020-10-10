import 'package:bimber/models/chat_thumbnail.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ChatThumbnailExtension on ChatThumbnail {
  Future<bool> checkIfRead() async {
    if (lastMessage == null) return true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(this.id);
    if (value != null) {
      DateTime lastRead = DateTime.parse(value);
      if (lastRead.isAfter(this.lastMessage.date)) return true;
    }
    return false;
  }

  markAsRead() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.id, DateTime.now().toIso8601String());
  }
}
