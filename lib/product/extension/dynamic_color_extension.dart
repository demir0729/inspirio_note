import 'package:flutter/material.dart';

import '../constant/color_constants.dart';

extension DynamicColorExtension on Color {
  Color get toDynamicColor => computeLuminance() > 0.179
      ? ColorConstants.ravenBlack
      : ColorConstants.shinyBridalGown;
  Brightness get toDynamicBrightness =>
      computeLuminance() > 0.179 ? Brightness.dark : Brightness.light;
  Color get toDynamicSplashColor =>
      computeLuminance() > 0.179 ? Colors.black54 : Colors.white54;
}
