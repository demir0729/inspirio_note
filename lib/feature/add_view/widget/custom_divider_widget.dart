import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/init/notifier/theme_notifier.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.watch<ThemeNotifier>().bottomAppBarIcon,
      width: 1,
      height: 24,
    );
  }
}
