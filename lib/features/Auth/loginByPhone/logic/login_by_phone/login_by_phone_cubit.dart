import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_by_phone_state.dart';

class LoginByPhoneCubit extends Cubit<LoginByPhoneState> {
  LoginByPhoneCubit() : super(LoginByPhoneInitial());

  Future<void> loginByPhone({required String phoneNumber}) async {
    emit(LoginByPhoneLoading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        emit(LoginByPhoneSuccess());
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(LoginByPhoneFailed(message: 'Something went wrong'));
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        emit(LoginByPhoneSendCode(verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        emit(LoginByPhoneFailed(message: 'Time out'));
      },
    );
  }
}
