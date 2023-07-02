import 'package:flutter/material.dart';

import '../../../product/constant/color_constants.dart';
import '../../../product/constant/id_and_key_constant.dart';
import '../../../product/enums/app_theme_enum.dart';
import '../../../product/enums/lottie_enum.dart';
import '../../../product/enums/svg_enum.dart';
import '../../../product/extension/lottie_extension.dart';
import '../../../product/extension/svg_extension.dart';
import '../cache/abstract_manager.dart';
import '../cache/map_cache.dart';
import '../themes/fox_wedding_theme.dart';
import '../themes/owl_night_theme.dart';
import '../themes/raven_black_theme.dart';
import '../themes/white_light_theme.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier() {
    userAppThemeInfo =
        MapItemCache(itemBoxkey: IdAndKeyConstant.mapItemsBoxKey);
    init();
  }

  init() async {
    await userAppThemeInfo.init();
    changeTheme(getTheme);
  }

  late final IGeneralCacheManager<Map<dynamic, dynamic>> userAppThemeInfo;

  late Color drawerSvgColor = ColorConstants.ravenBlack;
  late Color mainThemeLayerColor = ColorConstants.greyLight;
  late Color contentTextColor = ColorConstants.ravenRusty;
  late Color bottomAppBarIcon = ColorConstants.ravenRusty;
  late Color drawerBackColor = ColorConstants.ravenBlack;

  ThemeData _currentTheme = RavenBlackTheme.instance.theme();
  String _currentLottie = LottieItems.whitelight.getItems;
  String _currentDrawerBack = SvgItems.lotusback.getItem;
  ThemeData get currentTheme => _currentTheme;
  String get currentLottie => _currentLottie;
  String get currentDrawerBack => _currentDrawerBack;

  String get getTheme {
    final themeMap =
        userAppThemeInfo.getItem('') ?? {'currentTheme': 'whitelight'};
    try {
      final themeMapEntry = themeMap.entries.singleWhere(
        (element) => element.key == 'currentTheme',
      );
      return themeMapEntry.value;
    } catch (e) {
      return 'whitelight';
    }
  }

  saveTheme(String theme) async {
    await userAppThemeInfo.addItem({'currentTheme': theme});
  }

  changeTheme(String theme) {
    if (theme == AppThemes.ravenblack.name) {
      _currentTheme = RavenBlackTheme.instance.theme();
      _currentLottie = LottieItems.raven.getItems;
      _currentDrawerBack = SvgItems.ravenback.getItem;
      drawerSvgColor = ColorConstants.ravenBlack;
      mainThemeLayerColor = ColorConstants.greyLight;
      contentTextColor = ColorConstants.ravenRusty;
      bottomAppBarIcon = ColorConstants.greyLight;
      drawerBackColor = ColorConstants.greyLight;
      saveTheme(AppThemes.ravenblack.name);
    } else if (theme == AppThemes.owlnight.name) {
      _currentTheme = OwlNightTheme.instance.theme();
      _currentLottie = LottieItems.owl.getItems;
      _currentDrawerBack = SvgItems.owlback.getItem;
      drawerSvgColor = ColorConstants.color1;
      bottomAppBarIcon = ColorConstants.softPeach;
      mainThemeLayerColor = ColorConstants.softPeach;
      contentTextColor = ColorConstants.color3;
      drawerBackColor = ColorConstants.softPeach;
      saveTheme(AppThemes.owlnight.name);
    } else if (theme == AppThemes.foxwedding.name) {
      _currentTheme = FoxWeddingTheme.instance.theme();
      _currentLottie = LottieItems.fox.getItems;
      _currentDrawerBack = SvgItems.foxback.getItem;
      drawerSvgColor = ColorConstants.foxtail;
      mainThemeLayerColor = ColorConstants.shinyBridalGown;
      contentTextColor = ColorConstants.foxtail2;
      bottomAppBarIcon = ColorConstants.shinyBridalGown;
      drawerBackColor = ColorConstants.apricot;
      saveTheme(AppThemes.foxwedding.name);
    } else if (theme == AppThemes.whitelight.name) {
      _currentTheme = WhiteLightTheme.instance.theme();
      _currentLottie = LottieItems.whitelight.getItems;
      _currentDrawerBack = SvgItems.lotusback.getItem;
      drawerSvgColor = ColorConstants.cuteBlue;
      mainThemeLayerColor = ColorConstants.cuteBlue.withOpacity(0.9);
      contentTextColor = ColorConstants.ravenBlack;
      bottomAppBarIcon = ColorConstants.ravenBlack;
      drawerBackColor = ColorConstants.ravenBlack;
      saveTheme(AppThemes.whitelight.name);
    }

    notifyListeners();
  }
}
