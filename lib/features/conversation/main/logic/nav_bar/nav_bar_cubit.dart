import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());

  int index = 1;
  void changeIndex(int newIndex) {
    index = newIndex;
    emit(NavBarSelected());
  }
}
