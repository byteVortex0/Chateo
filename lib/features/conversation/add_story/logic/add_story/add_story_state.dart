part of 'add_story_cubit.dart';

sealed class AddStoryState extends Equatable {
  const AddStoryState();

  @override
  List<Object> get props => [];
}

final class AddStoryInitial extends AddStoryState {}

final class AddStoryLoading extends AddStoryState {}

final class AddStorySuccess extends AddStoryState {}

final class AddStoryError extends AddStoryState {
  final String message;

  const AddStoryError({required this.message});

  @override
  List<Object> get props => [message];
}
