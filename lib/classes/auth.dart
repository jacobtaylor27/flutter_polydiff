import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  String? get currentUserId => _auth.currentUser?.uid;
  String? get currentUserEmail => _auth.currentUser?.email;
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}