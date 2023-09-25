import 'package:flutter/material.dart';

ElevatedButton signInSignUpButton(BuildContext context, bool isLogin, Function onClick) {
  return ElevatedButton(
   onPressed: () {
    onClick();
   },
   child: Text(
    isLogin ? 'Log in' : 'Create an account',
   ),
  );
  
}
