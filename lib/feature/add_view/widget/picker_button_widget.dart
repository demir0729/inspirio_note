import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/init/notifier/theme_notifier.dart';
import '../../../product/constant/size_constant.dart';

class PickerButton extends StatelessWidget {
  const PickerButton({super.key, required this.onPressed, required this.png});
  final Function() onPressed;
  final String png;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.symmetric(horizontal: SizeConstant(context).width02),
      onPressed: onPressed,
      icon: Image.asset(
        png,
        width: SizeConstant(context).width05,
        color: context.watch<ThemeNotifier>().bottomAppBarIcon,
      ),
    );
  }
}


/*
SizedBox(
          width: w < 325 ? 35 : 45,
          height: w < 325 ? 35 : 45,
          child: Icon(
            iconData,
            color: context.watch<ThemeNotifier>().bottomAppBarIcon,
            size: w < 325 ? 20 : 27,
          ),
        ),
 */