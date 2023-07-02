import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/product/constant/duration_constant.dart';

import '../../product/constant/color_constants.dart';
import '../../product/constant/size_constant.dart';

Future<dynamic> customFlushbar(BuildContext context, String? title,
    {Duration? duration}) {
  return Flushbar(
    borderRadius: BorderRadius.circular(20),
    backgroundColor: ColorConstants.transGray,
    animationDuration: DurationConstant.duration1000(),
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    reverseAnimationCurve: Curves.easeOut,
    duration: duration ?? DurationConstant.duration2500(),
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    messageColor: ColorConstants.ravenBlack,
    margin: EdgeInsets.symmetric(vertical: SizeConstant(context).height11),
    maxWidth: SizeConstant(context).width4,
    padding: const EdgeInsets.all(10),
    messageText: Text(
      title ?? '',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: SizeConstant(context).width03,
          ),
    ),
  ).show(context);
}
