import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polydiff/classes/auth.dart';
import 'package:flutter_polydiff/screens/signin_screen.dart';
import 'package:flutter_polydiff/widgets/common/reusable_widget.dart';
import 'package:logger/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future signInWithEmailAndPassword() async {
    try{
      Auth().signOut().then((value) => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()))
      });
    } on FirebaseAuthException catch (e) {
        Logger().e(e);
    }
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
              Text(
                'Welcome ${Auth().currentUserEmail}',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),  
              const SizedBox(height: 40,),
              SizedBox(
                width: 300, // Set the width to your desired value
                child: basicButton(context, "Chat", () {})
            ),
            const SizedBox(height: 40,),
              SizedBox(
                width: 300, // Set the width to your desired value
                child: basicButton(context, "Sign Out", () {signInWithEmailAndPassword(); })
            ),
            ],
          )
        ) 
      ),);
  }
}