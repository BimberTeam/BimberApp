import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSubmitted;

  const ChatInput({Key key, @required this.onSubmitted}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  TextEditingController inputController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    inputController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.primaryVariant;
    TextStyle textStyle = TextStyle(
        color: Theme.of(context).colorScheme.primaryVariant,
        fontSize: 15,
        fontWeight: FontWeight.w900,
        fontFamily: 'Baloo');
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(32.0),
            ),
            margin: EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                  style: textStyle,
                  decoration: InputDecoration(
                    hintStyle: textStyle,
                    border: InputBorder.none,
                    hintText: "Wyślij wiadomość...",
                  ),
                  focusNode: focusNode,
                  textInputAction: TextInputAction.send,
                  controller: inputController,
                  onSubmitted: sendMessage,
                )),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendMessage(inputController.text);
                  },
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void sendMessage(String message) {
    widget.onSubmitted(message);
    inputController.text = '';
    focusNode.unfocus();
  }
}
