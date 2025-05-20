import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chateo/core/service/shared_pref/pref_key.dart';
import 'package:chateo/features/Auth/loginPersonalInfo/data/models/personal_info_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/service/shared_pref/shared_pref.dart';

part 'get_all_contacts_state.dart';

class GetAllContactsCubit extends Cubit<GetAllContactsState> {
  GetAllContactsCubit() : super(GetAllContactsLoading());

  final supabase = Supabase.instance.client;

  Future<void> getAllContacts() async {
    emit(GetAllContactsLoading());
    try {
      final response = await supabase.from('users').select();

      final userId = SharedPref.getValue(PrefKey.userId);

      response.removeWhere((element) => element['id'] == userId);

      // log('response: $response');

      if (response.isEmpty) {
        emit(GetAllContactsEmpty());
        return;
      }
      final data = response.map((e) => PersonalInfoModel.fromJson(e)).toList();
      emit(GetAllContactsSuccess(contacts: data));
    } catch (e) {
      log('Error fetching contacts: $e');
      emit(GetAllContactsError(e.toString()));
    }
  }

  // search contacts
  Future<void> searchContacts(String query) async {
    emit(GetAllContactsLoading());
    try {
      final response = await supabase.from('users').select();

      log('response: $response');

      final userId = SharedPref.getValue(PrefKey.userId);
      response.removeWhere((element) => element['id'] == userId);

      final filtered =
          response.where((element) {
            final fullName =
                '${element['frist_name']} ${element['last_name']}'
                    .toLowerCase();
            final phone =
                element['phone_number']?.toString().toLowerCase() ?? '';
            return fullName.contains(query) || phone.contains(query);
          }).toList();

      if (filtered.isEmpty) {
        emit(GetAllContactsEmpty());
        return;
      }

      final data = filtered.map((e) => PersonalInfoModel.fromJson(e)).toList();
      emit(GetAllContactsSuccess(contacts: data));
    } catch (e) {
      log('Error searching contacts: $e');
      emit(GetAllContactsError(e.toString()));
    }
  }
}
