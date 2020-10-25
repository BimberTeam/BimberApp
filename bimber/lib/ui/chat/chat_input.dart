import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final Function(String) onSubmitted;

  const ChatInput({Key key, @required this.onSubmitted}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatInputState();

}

class _ChatInputState extends State<ChatInput> {
  TextEditingController editingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    editingController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme
        .of(context)
        .colorScheme
        .primaryVariant;
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            decoration: BoxDecoration(border: Border.all(color: color),
              borderRadius: BorderRadius.circular(32.0),),
            margin: EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                Expanded(child: TextField(
                  style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primaryVariant,
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Baloo'),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primaryVariant,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Baloo'),
                    border:InputBorder.none,
                    hintText: "Wyślij wiadomość...",
                  ),
                  focusNode: focusNode,
                  textInputAction: TextInputAction.send,
                  controller: editingController,
                  onSubmitted: sendMessage,
                )),
                IconButton(icon: Icon(Icons.send), onPressed: () {
                  sendMessage(editingController.text);
                }, color: color,),
              ],
            ),
          ),
        ),

      ],
    );
  }

  void sendMessage(String message) {
    widget.onSubmitted(message);
    editingController.text = '';
    focusNode.unfocus();
  }
}