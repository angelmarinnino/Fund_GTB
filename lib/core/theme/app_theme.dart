import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors_theme.dart';

class AppTheme {
  static ThemeData light() {
    final ThemeData theme = ThemeData(
      fontFamily: 'Roboto',
      brightness: Brightness.light,
      primaryColor: ColorsAppTheme.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
    );

    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: ColorsAppTheme.primaryColor,
        secondary: ColorsAppTheme.secondColor,
      ),
    );
  }
}
