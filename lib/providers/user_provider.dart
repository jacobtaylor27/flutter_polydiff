import 'package:flutter/material.dart';
import 'package:flutter_polydiff/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  void setUser(User userToSet) {
    user = userToSet;
    notifyListeners();
  }
}