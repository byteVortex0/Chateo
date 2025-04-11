part of 'send_massage_cubit.dart';

sealed class SendMassageState extends Equatable {
  const SendMassageState();

  @override
  List<Object> get props => [];
}

final class SendMassageInitial extends SendMassageState {}

final class SendMassageLoading extends SendMassageState {}

final class SendMassageSuccess extends SendMassageState {
  const SendMassageSuccess({required this.chat});

  final ChatModel chat;

  @override
  List<Object> get props => [chat];
}

final class SendMassageError extends SendMassageState {
  const SendMassageError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
