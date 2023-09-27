import 'package:flutter_polydiff/models/user.dart';

class UserRepository {
  // get user by id
  UserDTO? getUserById(String uid) {}

  // add new user
  UserDTO? addUser(User user) {}

  // verify availability of username
  bool isUsernameAvailable(String username) {
    return true;
  }
}