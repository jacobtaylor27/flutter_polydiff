import 'package:flutter/material.dart';
import 'package:flutter_polydiff/widgets/auth/auth_widgets.dart';
import 'package:flutter_polydiff/widgets/common/reusable_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

final TextEditingController emailTextController = TextEditingController();
TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,0, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100),
              const Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),  
              const SizedBox(height: 50,),
              SizedBox(
                width: 300, // Set the width to your desired value
                child: basicTextField("Enter email address", Icons.person_outline, false, emailTextController),
            ),
            const SizedBox(height: 25,),
              SizedBox(
                width: 300, // Set the width to your desired value
                child: basicTextField("Enter your password", Icons.lock, true, passwordTextController),
            ),
            const SizedBox(height: 30,),
            signInSignUpButton(context, true, () {})
            ],
  
          )
        ) 
      ),);
  }
}