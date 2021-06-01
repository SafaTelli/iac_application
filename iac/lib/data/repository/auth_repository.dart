import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(final String email, final String password) async {
    var user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user!.uid;
  }

  Future<UserCredential> signUp(
      final String email, final String password) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result;
  }
}
