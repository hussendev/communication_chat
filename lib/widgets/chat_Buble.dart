import 'package:communication_chat/constant.dart';
import 'package:communication_chat/models/message.dart';
import 'package:communication_chat/models/person.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBuble extends StatelessWidget {
  ChatBuble({required this.message});
  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Text(message.id, textAlign: TextAlign.right),
          Container(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50))),
            child: Text(
              message.message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubleForFriend extends StatelessWidget {
  ChatBubleForFriend({required this.message});
  Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Text(message.id, textAlign: TextAlign.right),
          Container(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 16),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Text(
              message.message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
