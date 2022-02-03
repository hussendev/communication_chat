import 'package:communication_chat/firebase_options.dart';
import 'package:communication_chat/providers/chat_provider.dart';
import 'package:communication_chat/screens/chat_screen.dart';
import 'package:communication_chat/screens/login_screen.dart';
import 'package:communication_chat/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) {
        return ChatProvider();
      },
      child: CommunicationChat()));
}

class CommunicationChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'LoginPage': (context) => LoginPage(),
        'RegisterPage': (context) => RegisterScreen(),
        'ChatPage': (context) => ChatPage(),
      },
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginPage',
    );
  }
}
