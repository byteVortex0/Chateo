import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'update_width_state.dart';

class UpdateWidthCubit extends Cubit<UpdateWidthState> {
  UpdateWidthCubit() : super(UpdateWidthInitial());

  void updateMaxWidth({required double width1, required double width2}) {
    final maxWidth = width1 > width2 ? width1 : width2;
    emit(UpdateWidthChanged(maxWidth));
  }
}
