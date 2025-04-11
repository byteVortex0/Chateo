part of 'get_all_messages_cubit.dart';

sealed class GetAllMessagesState extends Equatable {
  const GetAllMessagesState();

  @override
  List<Object> get props => [];
}

final class GetAllMessagesLoading extends GetAllMessagesState {}

final class GetAllMessagesSuccess extends GetAllMessagesState {
  const GetAllMessagesSuccess({required this.chat});

  final ChatModel chat;

  @override
  List<Object> get props => [chat];
}

final class GetAllMessagesError extends GetAllMessagesState {
  const GetAllMessagesError(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}

final class GetAllMessagesEmpty extends GetAllMessagesState {}
