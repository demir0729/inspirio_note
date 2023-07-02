import 'package:flutter/material.dart';
import 'package:my_notes/product/constant/color_constants.dart';
import 'package:my_notes/product/constant/font_family_constant.dart';
import 'package:my_notes/product/extension/dynamic_color_extension.dart';

class RavenBlackTheme {
  RavenBlackTheme._();
  static RavenBlackTheme? _instance;
  static RavenBlackTheme get instance {
    if (_instance == null) {
      return _instance = RavenBlackTheme._();
    } else {
      return _instance!;
    }
  }

  ThemeData theme() {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorConstants.ravenBlack,
        background: ColorConstants.ravenRusty,
      ),
    ).copyWith(
      scaffoldBackgroundColor: ColorConstants.ravenRusty,
      cardColor: ColorConstants.greyLight,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w700,
          letterSpacing: 3,
          color: ColorConstants.greyLight,
        ),
        labelMedium: TextStyle(
          color: ColorConstants.greyLight,
          fontStyle: FontStyle.italic,
          fontFamily: FontFamilyConstant.barlowSemiCondensed,
        ),
        labelLarge: TextStyle(
          color: ColorConstants.ravenRusty,
          fontFamily: FontFamilyConstant.gotham,
          fontSize: 13,
        ),
        titleLarge: TextStyle(
          color: ColorConstants.greyLight,
          fontFamily: FontFamilyConstant.gotham,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w300,
          color: ColorConstants.greyLight,
        ),
        titleSmall: TextStyle(
          color: ColorConstants.ravenBlack,
          fontSize: 17,
          fontFamily: FontFamilyConstant.gotham,
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
        iconColor: ColorConstants.greyLight,
        textColor: ColorConstants.ravenBlack,
      ),
      drawerTheme:
          const DrawerThemeData(backgroundColor: ColorConstants.ravenBlack),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          letterSpacing: 1,
          fontWeight: FontWeight.w400,
          color: ColorConstants.greyLight,
        ),
        backgroundColor: ColorConstants.ravenBlack,
        iconTheme: IconThemeData(color: ColorConstants.greyLight),
      ),
      useMaterial3: true,
      iconTheme: const IconThemeData(
        color: ColorConstants.ravenRusty,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorConstants.ravenBlack,
        foregroundColor: ColorConstants.greyLight,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateColor.resolveWith(
            (states) => ColorConstants.ravenRusty.toDynamicColor),
      ),
      primaryColor: ColorConstants.ravenWarning,
      secondaryHeaderColor: ColorConstants.greyLight,
      dividerColor: ColorConstants.ravenBlack,
      switchTheme: const SwitchThemeData(
        trackColor: MaterialStatePropertyAll(ColorConstants.greyLight),
        thumbColor: MaterialStatePropertyAll(ColorConstants.ravenBlack),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          color: ColorConstants.ravenWarning,
          fontSize: 19,
        ),
      ),
    );
  }
}
