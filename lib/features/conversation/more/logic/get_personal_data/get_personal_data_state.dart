part of 'get_personal_data_cubit.dart';

@immutable
sealed class GetPersonalDataState {}

final class GetPersonalDataLoading extends GetPersonalDataState {}

final class GetPersonalDataSuccess extends GetPersonalDataState {
  final PersonalInfoModel personalInfoModel;

  GetPersonalDataSuccess({required this.personalInfoModel});
}

final class GetPersonalDataFailure extends GetPersonalDataState {
  final String error;

  GetPersonalDataFailure({required this.error});
}
