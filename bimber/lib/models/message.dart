import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import "package:bimber/models/status.dart";

class Message extends Equatable {
  bool get stringify => true;

  final Status status;
  final String message;

  Message({@required this.status, @required this.message});

  Message copyWith({Status status, String message}) {
    return Message(
        status: status ?? this.status, message: message ?? this.message);
  }

  @override
  List get props => [status, message];

  Map<String, dynamic> toJson() {
    return {"status": status?.toJson(), "message": message};
  }

  factory Message.fromJson(dynamic json) {
    if (json == null) return null;
    return Message(
        status: StatusExtension.fromJson(json["status"]),
        message: json["message"]);
  }
}
