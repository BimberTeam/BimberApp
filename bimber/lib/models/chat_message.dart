import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ChatMessage extends Equatable {
  bool get stringify => true;

  final String groupId;
  final String userId;
  final DateTime date;
  final String message;

  ChatMessage(
      {@required this.groupId,
      @required this.userId,
      @required this.date,
      @required this.message});

  ChatMessage copyWith(
      {String groupId, String userId, DateTime date, String message}) {
    return ChatMessage(
        groupId: groupId ?? this.groupId,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        message: message ?? this.message);
  }

  @override
  List get props => [groupId, userId, date, message];

  Map<String, dynamic> toJson() {
    return {
      "groupId": groupId,
      "userId": userId,
      "date": date?.toIso8601String(),
      "message": message
    };
  }

  factory ChatMessage.fromJson(dynamic json) {
    if (json == null) return null;
    return ChatMessage(
        groupId: json["groupId"],
        userId: json["userId"],
        date: json["date"] != null ? DateTime.parse(json["date"]) : null,
        message: json["message"]);
  }
}
