import 'package:bimber/models/chat_message.dart';
import 'package:bimber/resources/services/image_service.dart';
import 'package:bimber/ui/common/fixtures.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessageBox extends StatelessWidget {
  final ChatMessage message;
  final bool isReceived;
  final bool showUser;
  final bool showDate;
  const ChatMessageBox(
      {Key key,
      @required this.message,
      this.isReceived,
      this.showUser,
      this.showDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        showDate ? _date(context) : Container(),
        isReceived ? _receivedMessage(context) : _sentMessage(context),
      ],
    );
  }

  Widget _date(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        DateFormat('dd.MM HH:mm').format(message.date),
        style: TextStyle(
            color: Theme.of(context).colorScheme.primaryVariant,
            fontSize: 10,
            fontWeight: FontWeight.w400,
            fontFamily: 'Baloo'),
      ),
    );
  }

  Widget _sentMessage(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 3 / 4),
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryVariant,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Text(
            message.message,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'Baloo'),
          ),
        ));
  }

  Widget _receivedMessage(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Row(
        children: <Widget>[
          showUser
              ? Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        ImageService.getImageUrl(message.userId)),
                    radius: 12.0,
                  ),
                )
              : Container(
                  width: 32.0,
                  height: 24.0,
                ),
          Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 3 / 4),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).colorScheme.primaryVariant),
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Text(
              message.message,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryVariant,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Baloo'),
            ),
          ),
        ],
      ),
    );
  }
}
