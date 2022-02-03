import 'package:communication_chat/constant.dart';
import 'package:communication_chat/helper/ShowSnackBar.dart';
import 'package:communication_chat/models/person.dart';
import 'package:communication_chat/widgets/custom_text_field.dart';
import 'package:communication_chat/widgets/cutom_butom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  String id = 'RegisterPage';
  String? email;
  String? userName;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    'REGISTER',
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
                hintText: 'UserName',
                onChange: (data) {
                  userName = data;
                  Provider.of<Preson>(context).userName = userName;
                },
              ),
              SizedBox(
                height: 15,
              ),
              CoustomFormTextField(
                hintText: 'Email',
                onChange: (data) {
                  email = data;
                },
              ),
              SizedBox(
                height: 15,
              ),
              CoustomFormTextField(
                scure: true,
                onChange: (data) {
                  password = data;
                },
                hintText: 'Password',
              ),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                text: 'REGISTER',
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      var auth = FirebaseAuth.instance;
                      await registerUser(auth);
                      ShowMessage(
                        context,
                        Colors.green,
                        'Successfully Registered',
                      );
                      Navigator.pop(context);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        ShowMessage(
                            context, Colors.red, 'The password is too weak');
                      } else if (e.code == 'email-already-in-use') {
                        ShowMessage(
                            context, Colors.red, 'The email already exists');
                      }
                    } catch (e) {
                      ShowMessage(context, Colors.red, 'There wasan erorr');
                    }
                  } else {
                    print("error");
                  }
                },
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
                      Navigator.pop(context);
                    },
                    child: Text(
                      ' Login',
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
    );
  }

  Future<void> registerUser(FirebaseAuth auth) async {
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
