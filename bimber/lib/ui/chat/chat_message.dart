import 'package:bimber/models/chat_message.dart';
import 'package:bimber/resources/services/image_service.dart';
import 'package:flutter/material.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessage message;
  final bool isReceived;
  final bool showUser;
  const ChatMessageWidget({Key key,@required this.message,this.isReceived=false, this.showUser=true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.symmetric(vertical: 6.0,horizontal: 12.0),
          child: isReceived?_buildReceivedMessage(context):_buildSentMessage(context),
        ),
      ],
    );
  }
  Widget _buildSentMessage(BuildContext context){
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width*3/4 ),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryVariant,borderRadius: BorderRadius.circular(25.0),),
        child: Text(message.text, style:  TextStyle(
            color: Theme
                .of(context)
                .colorScheme
                .primaryVariant,
            fontSize: 15,
            fontWeight: FontWeight.w900,
            fontFamily: 'Baloo'),),
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context){
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          showUser?Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: CircleAvatar(backgroundImage: NetworkImage(ImageService.getRandomHarnasUrl(message.sender)),radius: 12.0,),
          ):Container(width: 32.0,height: 24.0,),
          Container(
            constraints: BoxConstraints(maxWidth:MediaQuery.of(context).size.width*3/4 ),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.primaryVariant),borderRadius: BorderRadius.circular(25.0),),
            child: Text(message.text,style:  TextStyle(
                color: Theme
                    .of(context)
                    .colorScheme
                    .primaryVariant,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontFamily: 'Baloo'),),
          ),
        ],
      ),
    );
  }
}