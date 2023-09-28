class User {
  User({
    required this.uid,
    required this.email,
    this.isLoggedIn,
    required this.username,
    this.avatarUrl,
  });

  String uid;
  String email;
  bool? isLoggedIn;
  String username;
  String? avatarUrl;

  Map<String, dynamic> toJson() {
    return {  
      'uid': uid,
      'email': email,
      'isLoggedIn': isLoggedIn,
      'username': username,
      // 'avatarUrl': avatarUrl,
    };
  }
}

class UserDTO {
  
}