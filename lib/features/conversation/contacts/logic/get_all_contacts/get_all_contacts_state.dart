part of 'get_all_contacts_cubit.dart';

@immutable
sealed class GetAllContactsState {}

final class GetAllContactsLoading extends GetAllContactsState {}

final class GetAllContactsSuccess extends GetAllContactsState {
  final List<PersonalInfoModel> contacts;

  GetAllContactsSuccess({required this.contacts});
}

final class GetAllContactsError extends GetAllContactsState {
  final String error;

  GetAllContactsError(this.error);
}

final class GetAllContactsEmpty extends GetAllContactsState {}
