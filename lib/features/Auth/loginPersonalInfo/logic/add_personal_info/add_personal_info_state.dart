part of 'add_personal_info_cubit.dart';

@immutable
sealed class AddPersonalInfoState {}

final class AddPersonalInfoInitial extends AddPersonalInfoState {}

final class AddPersonalInfoLoading extends AddPersonalInfoState {}

final class AddPersonalInfoSuccess extends AddPersonalInfoState {}

final class AddPersonalInfoFailure extends AddPersonalInfoState {
  final String error;

  AddPersonalInfoFailure({required this.error});
}
