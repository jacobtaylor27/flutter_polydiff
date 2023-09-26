import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polydiff/classes/auth.dart';
import 'package:flutter_polydiff/screens/home_screen.dart';
import 'package:flutter_polydiff/screens/signup_screen.dart';
import 'package:flutter_polydiff/widgets/auth/auth_widgets.dart';
import 'package:flutter_polydiff/widgets/common/reusable_widget.dart';
import 'package:logger/logger.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  Future signInWithEmailAndPassword() async {
    try{
      Auth().signInWithEmailAndPassword(emailTextController.text, passwordTextController.text).then((value) => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()))
      });
    } on FirebaseAuthException catch (e) {
      Logger().e(e);
    } 
  }

  onOptionsClick(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,0, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),  
              const SizedBox(height: 40,),
              SizedBox(
                width: 300, // Set the width to your desired value
                child: basicTextField("Enter email address", Icons.person_outline, false, emailTextController),
            ),
            const SizedBox(height: 25,),
              SizedBox(
                width: 300, // Set the width to your desired value
                child: basicTextField("Enter your password", Icons.lock, true, passwordTextController),
            ),
            const SizedBox(height: 20,),
            signInSignUpButton(context, true, () {signInWithEmailAndPassword();}),
              const SizedBox(height: 20,),
            authOptions(true, onOptionsClick)
            ],
          )
        ) 
      ),);
  }
}