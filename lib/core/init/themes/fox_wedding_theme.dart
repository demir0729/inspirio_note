import 'package:flutter/material.dart';
import 'package:my_notes/product/constant/color_constants.dart';
import 'package:my_notes/product/constant/font_family_constant.dart';
import 'package:my_notes/product/extension/dynamic_color_extension.dart';

class FoxWeddingTheme {
  FoxWeddingTheme._();
  static FoxWeddingTheme? _instance;
  static FoxWeddingTheme get instance {
    if (_instance == null) {
      return _instance = FoxWeddingTheme._();
    } else {
      return _instance!;
    }
  }

  ThemeData theme() {
    return ThemeData.from(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorConstants.foxtail,
        background: ColorConstants.foxtail,
      ),
    ).copyWith(
      scaffoldBackgroundColor: ColorConstants.apricot,
      cardColor: ColorConstants.shinyBridalGown,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w700,
          letterSpacing: 3,
          color: ColorConstants.shinyBridalGown,
        ),
        labelMedium: TextStyle(
          color: ColorConstants.foxWarning,
          fontStyle: FontStyle.italic,
          fontFamily: FontFamilyConstant.barlowSemiCondensed,
        ),
        labelLarge: TextStyle(
          color: ColorConstants.foxWarning,
          fontFamily: FontFamilyConstant.gotham,
          fontSize: 13,
        ),
        titleLarge: TextStyle(
          color: ColorConstants.shinyBridalGown,
          fontFamily: FontFamilyConstant.gotham,
          fontSize: 20,
        ),
        titleMedium: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w300,
          color: ColorConstants.apricot,
        ),
        titleSmall: TextStyle(
          color: ColorConstants.foxtail2,
          fontSize: 17,
          fontFamily: FontFamilyConstant.gotham,
        ),
        bodyLarge: TextStyle(
          color: ColorConstants.foxtail2,
          fontSize: 15,
          fontFamily: FontFamilyConstant.gotham,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontFamily: FontFamilyConstant.barlowSemiCondensed,
          fontStyle: FontStyle.italic,
          color: ColorConstants.foxtail,
        ),
        bodyMedium: TextStyle(
          fontFamily: FontFamilyConstant.barlowSemiCondensed,
          fontWeight: FontWeight.w300,
          color: ColorConstants.foxtail2,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: ColorConstants.apricot,
        textColor: ColorConstants.apricot,
      ),
      drawerTheme:
          const DrawerThemeData(backgroundColor: ColorConstants.foxtail2),
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          letterSpacing: 1,
          fontWeight: FontWeight.w400,
          color: ColorConstants.shinyBridalGown,
        ),
        backgroundColor: ColorConstants.foxtail2,
        iconTheme: IconThemeData(color: ColorConstants.shinyBridalGown),
      ),
      useMaterial3: true,
      iconTheme: const IconThemeData(
        color: ColorConstants.foxtail2,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorConstants.foxtail2,
        foregroundColor: ColorConstants.shinyBridalGown,
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateColor.resolveWith(
            (states) => ColorConstants.apricot.toDynamicColor),
      ),
      primaryColor: ColorConstants.shinyBridalGown,
      secondaryHeaderColor: ColorConstants.apricot,
      dividerColor: ColorConstants.foxtail2,
      switchTheme: const SwitchThemeData(
        trackColor: MaterialStatePropertyAll(ColorConstants.apricot),
        thumbColor: MaterialStatePropertyAll(ColorConstants.foxtail),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          fontFamily: FontFamilyConstant.gotham,
          color: ColorConstants.apricot,
          fontSize: 19,
        ),
      ),
    );
  }
}
