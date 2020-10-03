import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/message.dart";

class Chat extends Equatable {
  bool get stringify => true;

  final String id;
  final String groupId;
  final int avatarId;
  final String name;
  final Message lastMessage;

  Chat(
      {@required this.id,
      @required this.groupId,
      @required this.avatarId,
      @required this.name,
      @required this.lastMessage});

  Chat copyWith(
      {String id,
      String groupId,
      int avatarId,
      String name,
      Message lastMessage}) {
    return Chat(
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

  factory Chat.fromJson(dynamic json) {
    if (json == null) return null;
    return Chat(
        id: json["id"],
        groupId: json["groupId"],
        avatarId: json["avatarId"] as int,
        name: json["name"],
        lastMessage: Message.fromJson(json["lastMessage"]));
  }
}
