import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  Future<UserCredential> createUser(
      {required String email, required String password}) async {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> login(
      {required String email, required String password}) async {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
