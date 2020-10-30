import 'package:bimber/models/group.dart';
import 'package:flutter/material.dart';
import 'package:bimber/ui/common/utils.dart';

class ChatInfoViewScreen extends StatelessWidget{
  final Group group;
  final List<String> canBeAdded;
  final String currentUserId;

  const ChatInfoViewScreen({Key key, this.group, this.canBeAdded, this.currentUserId}) : super(key: key);
  
  Widget _header(BuildContext context){
    TextStyle style = TextStyle(
        color: Theme.of(context).colorScheme.primaryVariant,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontFamily: 'Baloo');
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: colorFromGroupId(group.id),
            radius: 50,
          ),
          SizedBox(height: 5,),
          Text("${group.members.length} członków", style: style,),
          SizedBox(height: 5,),
          Text("${group.averageAge} średnia wieku", style: style,),
          Divider(thickness: 2,)
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
          _header(context)
        ],
      ),
      )
    );
  }
  
}