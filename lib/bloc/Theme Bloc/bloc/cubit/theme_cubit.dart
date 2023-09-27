import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';


// enum ThemeModeState { light, dark }

// class ThemeCubit extends Cubit<ThemeModeState> {
//   ThemeCubit() : super(ThemeModeState.light);

//   void toggleTheme() {
//     emit(state == ThemeModeState.light ? ThemeModeState.dark : ThemeModeState.light);
//   }

//   ThemeMode getThemeData() {
//     return state == ThemeModeState.light ? ThemeMode.light : ThemeMode.dark;
//   }
// }

        



enum ThemeModeState { light, dark }

class ThemeCubit extends HydratedCubit<ThemeModeState> {
  ThemeCubit() : super(ThemeModeState.light);

  void toggleTheme() {
    emit(state == ThemeModeState.light ? ThemeModeState.dark : ThemeModeState.light);
  }

  ThemeMode getThemeData() {
    return state == ThemeModeState.light ? ThemeMode.light : ThemeMode.dark;
  }

  @override
  ThemeModeState? fromJson(Map<String, dynamic> json) {
    return json['themeMode'] == 'light' ? ThemeModeState.light : ThemeModeState.dark;
  }

  @override
  Map<String, dynamic>? toJson(ThemeModeState state) {
    return {'themeMode': state == ThemeModeState.light ? 'light' : 'dark'};
  }
}