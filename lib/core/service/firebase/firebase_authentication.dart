import 'package:firebase_auth/firebase_auth.dart';

//TODO: refactor this class

class FirebaseAuthentication {
  FirebaseAuthentication._();

  static final FirebaseAuthentication instance = FirebaseAuthentication._();

  factory FirebaseAuthentication() => instance;

  static final _auth = FirebaseAuth.instance;

  static Future<void> signInWithPhone(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (firebaseAuthException) {},
      codeSent: (verificationId, forceResendingToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static Future<void> signInWithCredential(
    PhoneAuthCredential credential,
  ) async {
    await _auth.signInWithCredential(credential);
  }
}
