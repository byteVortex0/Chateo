import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

// refactor this class
//* Done by creating bloc

class FirebaseAuthentication {
  FirebaseAuthentication._();

  static final FirebaseAuthentication instance = FirebaseAuthentication._();

  factory FirebaseAuthentication() => instance;

  static final _auth = FirebaseAuth.instance;
  static String? _verificationId;

  /// إرسال رمز التحقق عبر SMS
  static Future<String> signInWithPhone(String phoneNumber) async {
    Completer<String> completer = Completer<String>();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // تسجيل الدخول التلقائي (نادراً ما يحدث)
          await _auth.signInWithCredential(credential);
          completer.complete('تم التحقق تلقائيًا بنجاح ✅');
        },
        verificationFailed: (FirebaseAuthException e) {
          completer.completeError('فشل التحقق: ${e.message}');
          log('فشل التحقق: ${e.message}');
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          _verificationId =
              verificationId; // تخزين معرف التحقق لاستخدامه لاحقًا
          completer.complete('تم إرسال رمز التحقق بنجاح 📩');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId =
              verificationId; // تأكيد معرف التحقق عند انتهاء المهلة
          completer.completeError('انتهت مهلة استرداد الكود ⏳');
        },
      );
    } catch (e) {
      completer.completeError('حدث خطأ: $e');
    }

    return completer.future;
  }

  /// التحقق من الرمز الذي أدخله المستخدم
  static Future<String> verifyOTP(String otp) async {
    if (_verificationId == null) {
      return 'لم يتم إرسال رمز التحقق بعد ⛔';
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      return 'تم تسجيل الدخول بنجاح 🎉';
    } catch (e) {
      return 'رمز التحقق غير صحيح ❌';
    }
  }
}
