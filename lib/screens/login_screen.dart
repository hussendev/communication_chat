import 'package:communication_chat/constant.dart';
import 'package:communication_chat/helper/ShowSnackBar.dart';
import 'package:communication_chat/models/person.dart';
import 'package:communication_chat/screens/register_screen.dart';
import 'package:communication_chat/widgets/custom_text_field.dart';
import 'package:communication_chat/widgets/cutom_butom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  LoginPage();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLodaing = false;
  Preson? person;
  String? email;
  String? userName;
  String? password;
  // String s=ModalRoute.of(context)!.settings.arguments as String;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLodaing,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Communication Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
                Row(
                  children: [
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CoustomFormTextField(
                  hintText: 'UeserName',
                  onChange: (p0) {
                    userName = p0;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CoustomFormTextField(
                  hintText: 'Email',
                  onChange: (p0) {
                    email = p0;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CoustomFormTextField(
                  scure: true,
                  hintText: 'Password',
                  onChange: (p0) {
                    password = p0;
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLodaing = true;
                      setState(() {});
                      try {
                        var auth = FirebaseAuth.instance;
                        await loginUser(auth);
                        Navigator.pushNamed(context, 'ChatPage',
                            arguments: userName);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ShowMessage(context, Colors.red, 'No user found');
                        } else if (e.code == 'wrong-password') {
                          ShowMessage(context, Colors.red, 'Wrong password');
                        }
                      } catch (e) {
                        ShowMessage(context, Colors.red, 'There was an erorr');
                      }
                      isLodaing = false;
                      setState(() {});
                    } else {}
                  },
                  text: 'LOGIN',
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'don\'t heave an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterScreen().id);
                      },
                      child: Text(
                        ' Registers',
                        style: TextStyle(
                          color: Color(0XFFC7ede6),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser(FirebaseAuth auth) async {
    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);
  }
}
