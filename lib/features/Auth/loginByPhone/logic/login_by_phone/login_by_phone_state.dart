part of 'login_by_phone_cubit.dart';

@immutable
sealed class LoginByPhoneState {}

final class LoginByPhoneInitial extends LoginByPhoneState {}

final class LoginByPhoneLoading extends LoginByPhoneState {}

final class LoginByPhoneSuccess extends LoginByPhoneState {}

final class LoginByPhoneFailed extends LoginByPhoneState {
  final String message;

  LoginByPhoneFailed({required this.message});
}

final class LoginByPhoneSendCode extends LoginByPhoneState {
  final String verificationId;

  LoginByPhoneSendCode({required this.verificationId});
}
