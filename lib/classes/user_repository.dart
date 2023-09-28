import 'dart:convert';

import 'package:flutter_polydiff/classes/user_service.dart';
import 'package:flutter_polydiff/models/user.dart';

class UserRepository {
  dynamic getUserById(String uid) async {
    final response = await UserService().getUserById(uid);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  dynamic addUser(User user) async {
    final response = await UserService().createUser(user);

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  dynamic isUsernameAvailable(String username) async {
    final response = await UserService().isUsernameAvailable(username);

    if (response.statusCode == 200) {
      return json.decode(response.body)['isUsernameExists'];
    } else {
      return null;
    }
  }

  dynamic signOutUser(String id) async {
    final response = await UserService().signOutUser(id);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    else {
      return null;
    }
  }
  
  dynamic signInUser(String id) async {
    final response = await UserService().signInUser(id);
    if(response.statusCode == 200){
      return json.decode(response.body);
    }
    else {
      return null;
    }
  }

  dynamic isUserSignedIn(String id) async {
    final response = await UserService().isUserSignedIn(id);
    if(response.statusCode == 200){
      return json.decode(response.body)['isUserLoggedIn'];
    }
    else {
      return null;
    }
  }

}