import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.isDarkMode});

  final bool isDarkMode;

  ThemeMode get themeMode {
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  ThemeState copyWith({bool? isDarkMode}) {
    return ThemeState(isDarkMode: isDarkMode ?? this.isDarkMode);
  }

  @override
  List<Object?> get props => [isDarkMode];
}
