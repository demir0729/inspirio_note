import 'package:flutter/material.dart';
import 'package:my_notes/product/constant/color_constants.dart';
import 'package:my_notes/product/constant/font_family_constant.dart';
import 'package:my_notes/product/extension/dynamic_color_extension.dart';

class WhiteLightTheme {
  WhiteLightTheme._();
  static WhiteLightTheme? _instance;
  static WhiteLightTheme get instance {
    if (_instance == null) {
      return _instance = WhiteLightTheme._();
    } else {
      return _instance!;
    }
  }

  ThemeData theme() {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorConstants.color2,
        background: ColorConstants.cuteBlue,
      ),
    ).copyWith(
      scaffoldBackgroundColor: ColorConstants.whiteLight,
      cardColor: ColorConstants.cuteBlue,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w700,
          letterSpacing: 3,
          color: ColorConstants.cuteBlue,
        ),
        labelMedium: TextStyle(
          color: ColorConstants.ravenBlack,
          fontStyle: FontStyle.italic,
          fontFamily: FontFamilyConstant.barlowSemiCondensed,
        ),
        labelLarge: TextStyle(
          color: ColorConstants.ravenBlack,
          fontFamily: FontFamilyConstant.gotham,
          fontSize: 13,
        ),
        titleLarge: TextStyle(
          color: ColorConstants.ravenBlack,
          fontFamily: FontFamilyConstant.gotham,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w300,
          color: ColorConstants.ravenBlack,
        ),
        titleSmall: TextStyle(
          fontSize: 17,
          fontFamily: FontFamilyConstant.gotham,
          color: ColorConstants.ravenBlack,
        ),
        bodyLarge: TextStyle(
          color: ColorConstants.ravenBlack,
          fontSize: 15,
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontFamily: FontFamilyConstant.barlowSemiCondensed,
          fontStyle: FontStyle.italic,
          color: ColorConstants.ravenBlack,
        ),
        bodyMedium: TextStyle(
          fontFamily: FontFamilyConstant.barlowSemiCondensed,
          fontWeight: FontWeight.w300,
          color: ColorConstants.ravenBlack,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: ColorConstants.ravenBlack,
        textColor: ColorConstants.ravenBlack,
      ),
      drawerTheme:
          const DrawerThemeData(backgroundColor: ColorConstants.whiteLight),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          letterSpacing: 1,
          fontWeight: FontWeight.w400,
          color: ColorConstants.ravenBlack,
        ),
        backgroundColor: ColorConstants.whiteLight,
        iconTheme: IconThemeData(color: ColorConstants.ravenBlack),
      ),
      useMaterial3: true,
      iconTheme: const IconThemeData(
        color: ColorConstants.ravenBlack,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorConstants.ravenBlack,
        foregroundColor: ColorConstants.whiteLight,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateColor.resolveWith(
            (states) => ColorConstants.color3.toDynamicColor),
      ),
      primaryColor: ColorConstants.ravenGrey,
      secondaryHeaderColor: ColorConstants.cuteBlue,
      dividerColor: ColorConstants.ravenBlack,
      switchTheme: const SwitchThemeData(
        trackColor: MaterialStatePropertyAll(ColorConstants.cuteBlue),
        thumbColor: MaterialStatePropertyAll(ColorConstants.ravenBlack),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        suffixIconColor: Colors.grey,
        hintStyle: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          color: Colors.grey,
          fontSize: 19,
        ),
      ),
    );
  }
}
