import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/chat_message.dart";

class ChatThumbnail extends Equatable {
  bool get stringify => true;

  final String groupId;
  final String name;
  final ChatMessage lastMessage;

  ChatThumbnail(
      {@required this.groupId,
      @required this.name,
      @required this.lastMessage});

  ChatThumbnail copyWith(
      {String groupId, String name, ChatMessage lastMessage}) {
    return ChatThumbnail(
        groupId: groupId ?? this.groupId,
        name: name ?? this.name,
        lastMessage: lastMessage ?? this.lastMessage);
  }

  @override
  List get props => [groupId, name, lastMessage];

  Map<String, dynamic> toJson() {
    return {
      "groupId": groupId,
      "name": name,
      "lastMessage": lastMessage?.toJson()
    };
  }

  factory ChatThumbnail.fromJson(dynamic json) {
    if (json == null) return null;
    return ChatThumbnail(
        groupId: json["groupId"],
        name: json["name"],
        lastMessage: ChatMessage.fromJson(json["lastMessage"]));
  }
}
