import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitial());

  Future<void> verifyOTP({
    required String otp,
    required String verificationId,
  }) async {
    emit(VerifyOtpLoading());
    try {
      firebase_auth.PhoneAuthCredential credential = firebase_auth
          .PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await firebase_auth.FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final fcmToken = await FirebaseMessaging.instance.getToken();

      emit(VerifyOtpSuccess(token: fcmToken ?? ''));
    } catch (e) {
      log('Error during OTP verification: $e');
      emit(VerifyOtpFailed(message: 'Invalid OTP'));
    }
  }
}
