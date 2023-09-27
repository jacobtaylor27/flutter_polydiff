class User {
  User({
    required this.uid,
    required this.email,
    required this.isLoggedIn,
    required this.username,
    this.avatarUrl,
  });

  String uid;
  String email;
  bool isLoggedIn;
  String username;
  String? avatarUrl;
}

class UserDTO {
  
}