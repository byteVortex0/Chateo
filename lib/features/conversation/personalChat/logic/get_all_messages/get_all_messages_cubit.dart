import 'package:bloc/bloc.dart';
import 'package:chateo/features/conversation/chats/data/model/chat_model.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_all_messages_state.dart';

class GetAllMessagesCubit extends Cubit<GetAllMessagesState> {
  GetAllMessagesCubit() : super(GetAllMessagesLoading());

  final supabase = Supabase.instance.client;

  Stream<List<dynamic>> getAllMessages({required String chatId}) {
    emit(GetAllMessagesLoading());
    try {
      final response = supabase
          .from('chats')
          .select('chat_data')
          .eq('id', chatId)
          .asStream()
          .map((event) {
            if (event.isNotEmpty) {
              final chatData = event[0]['chat_data'] as List<dynamic>;
              if (chatData.isEmpty) {
                emit(GetAllMessagesEmpty());
              } else {
                emit(GetAllMessagesSuccess(chat: ChatModel.fromJson(event[0])));
              }
              return chatData.map((e) => ChatData.fromJson(e)).toList();
            } else {
              emit(GetAllMessagesEmpty());
              return [];
            }
          });

      // Use stream in a proper builder to listen to changes
      return response;
    } catch (e) {
      emit(GetAllMessagesError(e.toString()));
      rethrow;
    }
  }
}
