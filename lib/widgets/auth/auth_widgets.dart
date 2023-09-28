import 'package:flutter/material.dart';

ElevatedButton signInSignUpButton(BuildContext context, bool isLogin, Function onClick, {bool disabled = false}) {
  return ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey; // Change the color for disabled state
        }
        return Colors.blue; // Change the color for enabled state
      }),
    ),
   onPressed: disabled? null : () {
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