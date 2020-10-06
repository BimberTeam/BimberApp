import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/chat_message.dart";

class ChatThumbnail extends Equatable {
  bool get stringify => true;

  final String id;
  final String groupId;
  final int avatarId;
  final String name;
  final ChatMessage lastMessage;

  ChatThumbnail(
      {@required this.id,
      @required this.groupId,
      @required this.avatarId,
      @required this.name,
      @required this.lastMessage});

  ChatThumbnail copyWith(
      {String id,
      String groupId,
      int avatarId,
      String name,
      ChatMessage lastMessage}) {
    return ChatThumbnail(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        avatarId: avatarId ?? this.avatarId,
        name: name ?? this.name,
        lastMessage: lastMessage ?? this.lastMessage);
  }

  @override
  List get props => [id, groupId, avatarId, name, lastMessage];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "groupId": groupId,
      "avatarId": avatarId,
      "name": name,
      "lastMessage": lastMessage?.toJson()
    };
  }

  factory ChatThumbnail.fromJson(dynamic json) {
    if (json == null) return null;
    return ChatThumbnail(
        id: json["id"],
        groupId: json["groupId"],
        avatarId: json["avatarId"] as int,
        name: json["name"],
        lastMessage: ChatMessage.fromJson(json["lastMessage"]));
  }
}
