part of 'verify_otp_cubit.dart';

@immutable
sealed class VerifyOtpState {}

final class VerifyOtpInitial extends VerifyOtpState {}

final class VerifyOtpLoading extends VerifyOtpState {}

final class VerifyOtpSuccess extends VerifyOtpState {}

final class VerifyOtpFailed extends VerifyOtpState {
  final String message;
  VerifyOtpFailed({required this.message});
}
