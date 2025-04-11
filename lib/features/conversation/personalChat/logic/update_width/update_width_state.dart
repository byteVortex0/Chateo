part of 'update_width_cubit.dart';

@immutable
sealed class UpdateWidthState {}

final class UpdateWidthInitial extends UpdateWidthState {}

final class UpdateWidthChanged extends UpdateWidthState {
  final double maxWidth;

  UpdateWidthChanged(this.maxWidth);
}
