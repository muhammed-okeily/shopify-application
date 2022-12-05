// ignore_for_file: await_only_futures

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final auth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    final authResult = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return authResult;
  }

  Future<UserCredential> signIn(String email, String password) async {
    final authResult =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult;
  }

  Future getUser() async {
    return auth.currentUser;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
