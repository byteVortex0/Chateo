part of 'swipe_massege_cubit.dart';

sealed class SwipeMassegeState extends Equatable {
  const SwipeMassegeState();

  @override
  List<Object> get props => [];
}

final class SwipeMassegeInitial extends SwipeMassegeState {}

final class SwipeMassegeSuccess extends SwipeMassegeState {
  final ChatData chatData;
  const SwipeMassegeSuccess({required this.chatData});
}
