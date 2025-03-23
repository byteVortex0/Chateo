import 'package:firebase_auth/firebase_auth.dart';
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
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(VerifyOtpSuccess());
    } catch (e) {
      emit(VerifyOtpFailed(message: 'Invalid OTP'));
    }
  }
}
