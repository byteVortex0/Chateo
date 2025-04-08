import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chateo/core/service/shared_pref/pref_key.dart';
import 'package:chateo/core/service/shared_pref/shared_pref.dart';
import 'package:chateo/features/Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'get_personal_data_state.dart';

class GetPersonalDataCubit extends Cubit<GetPersonalDataState> {
  GetPersonalDataCubit() : super(GetPersonalDataLoading());

  final supabase = Supabase.instance.client;

  Future<void> getPersonalData() async {
    emit(GetPersonalDataLoading());
    try {
      final userId = SharedPref.getValue(PrefKey.userId);
      if (userId == null) {
        emit(GetPersonalDataFailure(error: 'User ID not found'));
        return;
      }
      final response =
          await supabase
              .from('users')
              .select('frist_name, last_name, phone_number, image_url')
              .eq('id', userId)
              .limit(1)
              .maybeSingle();

      log('User ID: $userId');
      log('Response: $response');

      if (response != null) {
        emit(
          GetPersonalDataSuccess(
            personalInfoModel: PersonalInfoModel(
              firstName: response['frist_name'],
              lastName: response['last_name'],
              phoneNumber: response['phone_number'],
              imageUrl: response['image_url'],
            ),
          ),
        );
      } else {
        log('No data found');
        emit(GetPersonalDataFailure(error: 'No data found'));
      }
    } catch (e) {
      log('Error fetching personal data: $e');
      emit(GetPersonalDataFailure(error: e.toString()));
    }
  }
}
