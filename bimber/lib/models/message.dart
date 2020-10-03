import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Message extends Equatable {
  bool get stringify => true;

  final String id;
  final String groupId;
  final DateTime date;
  final String text;
  final String sender;

  Message(
      {@required this.id,
      @required this.groupId,
      @required this.date,
      @required this.text,
      @required this.sender});

  Message copyWith(
      {String id, String groupId, DateTime date, String text, String sender}) {
    return Message(
        id: id ?? this.id,
        groupId: groupId ?? this.groupId,
        date: date ?? this.date,
        text: text ?? this.text,
        sender: sender ?? this.sender);
  }

  @override
  List get props => [id, groupId, date, text, sender];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "groupId": groupId,
      "date": date?.toIso8601String(),
      "text": text,
      "sender": sender
    };
  }

  factory Message.fromJson(dynamic json) {
    if (json == null) return null;
    return Message(
        id: json["id"],
        groupId: json["groupId"],
        date: json["date"] != null ? DateTime.parse(json["date"]) : null,
        text: json["text"],
        sender: json["sender"]);
  }
}
