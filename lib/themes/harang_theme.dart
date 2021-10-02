import 'package:flutter/material.dart';
import 'package:harang/themes/color_theme.dart';

ThemeData harang_theme = ThemeData(
    accentColor: purpleOne,
    scrollbarTheme: ScrollbarThemeData(
        isAlwaysShown: true,
        thickness: MaterialStateProperty.all(6),
        thumbColor: MaterialStateProperty.all(purpleOne.withOpacity(0.8)),
        radius: Radius.circular(10),
        minThumbLength: 60),
);
