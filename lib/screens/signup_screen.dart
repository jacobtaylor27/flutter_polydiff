import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_polydiff/classes/auth.dart';
import 'package:flutter_polydiff/classes/user_repository.dart';
import 'package:flutter_polydiff/models/user.dart';
import 'package:flutter_polydiff/providers/user_provider.dart';
import 'package:flutter_polydiff/screens/home_screen.dart';
import 'package:flutter_polydiff/screens/signin_screen.dart';
import 'package:flutter_polydiff/widgets/auth/auth_widgets.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController usernameTextController = TextEditingController();
  FocusNode usernameFocusNode = FocusNode();
  String errorFirebase = '';
  bool _isUsernameAvailable = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isCredentialsValid = false;
  bool _isEmailEmpty = true;
  bool _isPasswordEmpty = true;

  @override
  void initState() {
    super.initState();
    usernameFocusNode.addListener(() {
      if (!usernameFocusNode.hasFocus) {
        isUsernameAvailable();
      }
    });
  }

  Future signInWithEmailAndPassword() async {
    try{
      Auth().createUserWithEmailAndPassword(emailTextController.text, passwordTextController.text)
      .then((value) => {
       if(createAccountDB(User(email: emailTextController.text, uid: value.user!.uid, username: usernameTextController.text)) != null){
          Provider.of<UserProvider>(context, listen: false).setUser(User(email: emailTextController.text, uid: value.user!.uid, username: usernameTextController.text, isLoggedIn: true)),
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()))
       }
      });
    } on auth.FirebaseAuthException catch (e) {
      Logger().e(e);
    } 
  }

  dynamic createAccountDB(User user) async {
      final response = await UserRepository().addUser(user);
      return response;
  }

  void isUsernameAvailable() async {
    final response = await UserRepository().isUsernameAvailable(usernameTextController.text);
    Logger().e(response);
    if (response != null) {
      if(response){
        setState(() {
          _isUsernameAvailable = false;
          _isCredentialsValid = _isEmailValid && _isPasswordValid && _isUsernameAvailable;
        });
      }
      else {
        setState(() {
          _isUsernameAvailable = true;
        });
      }
    }
  }

  onOptionsClick(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body:
       Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,0, 20, 0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              const Text(
                'Create an account',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),  
              const SizedBox(height: 20,),
              if(errorFirebase != '') Text(errorFirebase, style: const TextStyle(color: Colors.red),),
              const SizedBox(height: 20,),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: usernameTextController,
                  focusNode: usernameFocusNode,
                  decoration: InputDecoration(
                    errorText: _isUsernameAvailable ? null : "Username already exists",
                    hintText: "Enter your username",
                    prefixIcon: const Icon(Icons.person_outline, color:Colors.blue,),
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
              const SizedBox(height: 25,),
              SizedBox(
                width: 300,
                child: TextFormField(
                  controller: emailTextController,
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
            const SizedBox(height: 25,),
              SizedBox(
                width: 300, // Set the width to your desired value
                child: TextFormField(
                  controller: passwordTextController,
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
            const SizedBox(height: 20,),
            signInSignUpButton(context, false, () {signInWithEmailAndPassword();}, disabled: (!_isCredentialsValid || _isEmailEmpty || _isPasswordEmpty)),
              const SizedBox(height: 20,),
            authOptions(false, onOptionsClick)
            ],
          )
        ) 
      ),);
  }
}