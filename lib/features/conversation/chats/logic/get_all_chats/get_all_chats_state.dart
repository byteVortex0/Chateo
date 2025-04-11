part of 'get_all_chats_cubit.dart';

@immutable
sealed class GetAllChatsState {}

final class GetAllChatsLoading extends GetAllChatsState {}

final class GetAllChatsSuccess extends GetAllChatsState {
  final List<ChatModel> chats;

  GetAllChatsSuccess(this.chats);
}

final class GetAllChatsFailure extends GetAllChatsState {
  final String error;

  GetAllChatsFailure(this.error);
}

final class GetAllChatsEmpty extends GetAllChatsState {}
