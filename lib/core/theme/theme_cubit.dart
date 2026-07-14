import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required SharedPreferences preferences})
    : _preferences = preferences,
      super(
        ThemeState(
          isDarkMode: preferences.getBool(_darkModePreferenceKey) ?? false,
        ),
      );

  static const String _darkModePreferenceKey = 'is_dark_mode';

  final SharedPreferences _preferences;

  Future<void> setDarkMode(bool isDarkMode) async {
    if (state.isDarkMode == isDarkMode) {
      return;
    }

    emit(state.copyWith(isDarkMode: isDarkMode));

    await _preferences.setBool(_darkModePreferenceKey, isDarkMode);
  }

  Future<void> toggleTheme() async {
    await setDarkMode(!state.isDarkMode);
  }
}
