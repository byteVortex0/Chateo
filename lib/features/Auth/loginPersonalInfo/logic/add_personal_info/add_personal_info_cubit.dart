import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show immutable;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/service/shared_pref/pref_key.dart';
import '../../../../../core/service/shared_pref/shared_pref.dart';
import '../../data/models/personal_info_model.dart';

part 'add_personal_info_state.dart';

class AddPersonalInfoCubit extends Cubit<AddPersonalInfoState> {
  AddPersonalInfoCubit() : super(AddPersonalInfoInitial());

  final supabase = Supabase.instance.client;

  Future<void> addPersonalInfo({
    required PersonalInfoModel personalInfoModel,
  }) async {
    emit(AddPersonalInfoLoading());

    try {
      log('Adding personal info: ${personalInfoModel.toJson()}');
      final response =
          await supabase
              .from('users')
              .insert(personalInfoModel.toJson())
              .select();

      log('Response: $response');
      if (response.isEmpty) {
        emit(
          AddPersonalInfoFailure(
            error: 'Failed to add user: No response received',
          ),
        );
        return;
      }

      final userId = response[0]['id'];

      SharedPref.setValue(PrefKey.userId, userId);

      emit(AddPersonalInfoSuccess());
    } catch (e) {
      log('Error adding personal info: $e');
      emit(AddPersonalInfoFailure(error: 'Failed to add user: $e'));
    }
  }
}
