import 'package:communication_chat/constant.dart';
import 'package:communication_chat/models/message.dart';
import 'package:communication_chat/models/person.dart';
import 'package:communication_chat/widgets/chat_Buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  final _controller = ScrollController();
  Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('messages').snapshots();
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var userName = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (var i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                    ),
                    Text('Communication Chat'),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == userName
                            ? ChatBuble(
                                message: messagesList[index],
                              )
                            : ChatBubleForFriend(message: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        messages.add(
                          {
                            'message': value,
                            'createdAt': DateTime.now(),
                            'id': userName,
                          },
                        );
                        controller.clear();
                        _controller.animateTo(
                          0,
                          duration: Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: kPrimaryColor)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(body: Container(child: Text('Loading...')));
          }
        });
  }
}
