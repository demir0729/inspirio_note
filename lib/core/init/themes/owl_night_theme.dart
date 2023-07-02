import 'package:flutter/material.dart';
import 'package:my_notes/product/constant/color_constants.dart';
import 'package:my_notes/product/constant/font_family_constant.dart';
import 'package:my_notes/product/extension/dynamic_color_extension.dart';

class OwlNightTheme {
  OwlNightTheme._();
  static OwlNightTheme? _instance;
  static OwlNightTheme get instance {
    if (_instance == null) {
      return _instance = OwlNightTheme._();
    } else {
      return _instance!;
    }
  }

  ThemeData theme() {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorConstants.color2,
        background: ColorConstants.color3,
      ),
    ).copyWith(
      scaffoldBackgroundColor: ColorConstants.color3,
      cardColor: ColorConstants.ravenGrey,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w700,
          letterSpacing: 3,
          color: ColorConstants.softPeach,
        ),
        labelMedium: TextStyle(
          color: ColorConstants.softPeach,
          fontStyle: FontStyle.italic,
          fontFamily: FontFamilyConstant.barlowSemiCondensed,
        ),
        labelLarge: TextStyle(
          color: ColorConstants.color1,
          fontFamily: FontFamilyConstant.gotham,
          fontSize: 13,
        ),
        titleLarge: TextStyle(
          color: ColorConstants.softPeach,
          fontFamily: FontFamilyConstant.gotham,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w300,
          color: ColorConstants.softPeach,
        ),
        titleSmall: TextStyle(
          color: ColorConstants.color3,
          fontSize: 17,
          fontFamily: FontFamilyConstant.gotham,
        ),
        bodyLarge: TextStyle(
          color: ColorConstants.color5,
          fontSize: 15,
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontFamily: FontFamilyConstant.barlowSemiCondensed,
          fontStyle: FontStyle.italic,
          color: ColorConstants.color1,
        ),
        bodyMedium: TextStyle(
          fontFamily: FontFamilyConstant.barlowSemiCondensed,
          fontWeight: FontWeight.w300,
          color: ColorConstants.color3,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: ColorConstants.softPeach,
        textColor: ColorConstants.softPeach,
      ),
      drawerTheme:
          const DrawerThemeData(backgroundColor: ColorConstants.color3),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          letterSpacing: 1,
          fontWeight: FontWeight.w400,
          color: ColorConstants.softPeach,
        ),
        backgroundColor: ColorConstants.color1,
        iconTheme: IconThemeData(color: ColorConstants.softPeach),
      ),
      useMaterial3: true,
      iconTheme: const IconThemeData(
        color: ColorConstants.color4,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorConstants.color1,
        foregroundColor: ColorConstants.softPeach,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateColor.resolveWith(
            (states) => ColorConstants.color3.toDynamicColor),
      ),
      primaryColor: ColorConstants.owlTears,
      secondaryHeaderColor: ColorConstants.softPeach,
      dividerColor: ColorConstants.color1,
      switchTheme: const SwitchThemeData(
        trackColor: MaterialStatePropertyAll(ColorConstants.softPeach),
        thumbColor: MaterialStatePropertyAll(ColorConstants.color1),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          color: ColorConstants.owlTears,
          fontSize: 19,
        ),
      ),
    );
  }
}
