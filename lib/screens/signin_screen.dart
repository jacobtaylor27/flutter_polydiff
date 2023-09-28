import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_polydiff/classes/auth.dart';
import 'package:flutter_polydiff/classes/user_repository.dart';
import 'package:flutter_polydiff/models/user.dart';
import 'package:flutter_polydiff/providers/user_provider.dart';
import 'package:flutter_polydiff/screens/home_screen.dart';
import 'package:flutter_polydiff/screens/signup_screen.dart';
import 'package:flutter_polydiff/widgets/auth/auth_widgets.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isCredentialsValid = false;
  bool _isEmailEmpty = true;
  bool _isPasswordEmpty = true;
  String errorFirebase = '';

  Future signInWithEmailAndPassword() async {
    try{
      Auth().signInWithEmailAndPassword(emailTextController.text, passwordTextController.text)
      .then((value) => {
        isUserLoggedIn(value.user!.uid)
      })
      .catchError((e) => {
        setState(() {
        errorFirebase = e.message!;
      })
      });
    } on auth.FirebaseAuthException catch (e) {
      setState(() {
        errorFirebase = e.message!;
      });
    } 
  }

  isUserLoggedIn(String userUid) async {
    final isSignedIn = await UserRepository().isUserSignedIn(userUid);
    if(!isSignedIn){
      setUser(userUid);
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    }
    else {
      // TO DO button pour se deconnecter
      setState(() {
        errorFirebase = 'User already logged in';
      });
    }
  }

  setUser(String userUid) async {
    await UserRepository().signInUser(userUid);
    final response = await UserRepository().getUserById(userUid);
    Provider.of<UserProvider>(context, listen: false).setUser(
      User(
        email: response['email'], 
        uid: response['uid'], 
        username: response['username'], 
        isLoggedIn: true
        )
      );
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
              const SizedBox(height: 20,),
              if(errorFirebase != '') Text(errorFirebase, style: const TextStyle(color: Colors.red),),
              const SizedBox(height: 20,),
              SizedBox(
                width: 300, // Set the width to your desired value
                child: 
                SizedBox(
                width: 300,
                child: TextFormField(
                  controller: emailTextController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(60),
                  ],
                  onChanged: (string) => {
                    setState(() {
                      _isEmailValid = emailTextController.text.contains('@');
                      _isEmailEmpty = emailTextController.text.isEmpty;
                      _isCredentialsValid = _isEmailValid && _isPasswordValid;
                    })
                  },
                  decoration: InputDecoration(
                    errorText: _isEmailValid ? null : "Please enter a valid email address",
                    hintText: "Enter your email address",
                    prefixIcon: const Icon(Icons.email_outlined, color:Colors.blue,),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                )
              ),
            ),
            const SizedBox(height: 25,),
              SizedBox(
                width: 300, // Set the width to your desired value
                child:
                SizedBox(
                width: 300, // Set the width to your desired value
                child: TextFormField(
                  controller: passwordTextController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(25),
                  ],
                  onChanged: (string) => {
                    setState(() {
                      _isPasswordValid = passwordTextController.text.length >= 6;
                      _isPasswordEmpty = passwordTextController.text.isEmpty;
                      _isCredentialsValid = _isEmailValid && _isPasswordValid;
                    })
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    errorText: _isPasswordValid ? null : "Password must be at least 6 characters long",
                    hintText: "Enter your password",
                    prefixIcon: const Icon(Icons.lock_outline, color:Colors.blue,),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                )
              ),
            ),
            const SizedBox(height: 20,),
            signInSignUpButton(context, true, () {signInWithEmailAndPassword();}, disabled: (!_isCredentialsValid || _isEmailEmpty || _isPasswordEmpty)),
              const SizedBox(height: 20,),
            authOptions(true, onOptionsClick)
            ],
          )
        ) 
      ),
    );
  }
}