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

Row authOptions(bool isLogin, Function onClick) {
  return Row(
   mainAxisAlignment: MainAxisAlignment.center,
   children: <Widget>[
    Text(
     isLogin? 'Don\'t have an account? : ' : 'Already have an account? :',
     style: const TextStyle(fontSize: 18),
    ),
    TextButton(
     onPressed: () {onClick();},
     child: Text(
      isLogin? 'Create an account' : 'Log in',
      style: const TextStyle(fontSize: 18),
     ),
    )
   ],
  );
}