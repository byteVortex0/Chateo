import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../chats/data/model/chat_model.dart';

part 'swipe_massege_state.dart';

class SwipeMassegeCubit extends Cubit<SwipeMassegeState> {
  SwipeMassegeCubit() : super(SwipeMassegeInitial());

  void onSwipe({required chatData}) {
    emit(SwipeMassegeInitial());
    emit(SwipeMassegeSuccess(chatData: chatData));
  }

  void onSwipeCancel() {
    emit(SwipeMassegeInitial());
  }
}
