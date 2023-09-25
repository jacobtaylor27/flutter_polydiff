import 'package:flutter/material.dart';

TextField basicTextField(String text, IconData icon, bool isPasswordType, TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    cursorColor: Colors.black,
    decoration: InputDecoration(
      prefixIcon: Icon(icon, color: Colors.blue,),
      hintText: text,
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
    keyboardType: isPasswordType ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}