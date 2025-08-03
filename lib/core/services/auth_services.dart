import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(String email, String password);
  User? currentUser();
  Future<void> logOut();
  // Future<bool> signInWithGoogle();
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User? currentUser() {
    return _firebaseAuth.currentUser;
  }


  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> logOut() async {
    // await GoogleSignIn( ).signOut();

    await _firebaseAuth.signOut();
  }

  // @override
  // Future<bool> signInWithGoogle() async {
  //   final googleSignIn = await GoogleSignIn().signIn();
  //   final googleAuth = await googleSignIn?.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //   final userCredential = await _firebaseAuth.signInWithCredential(credential);
  //   if (userCredential.user != null) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
