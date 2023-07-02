import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../feature/home_view/model/home_provider.dart';
import '../../../product/constant/duration_constant.dart';
import '../../../product/constant/size_constant.dart';
import '../../../product/extension/dynamic_color_extension.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/model/note_model.dart';
import '../../animations/transition_animation.dart';
import '../../init/notifier/theme_notifier.dart';

class DropDownArrowIcon extends StatelessWidget {
  const DropDownArrowIcon({
    super.key,
    required this.query,
    required this.isNoteCard,
    this.item,
  });
  final bool query;
  final NoteModel? item;
  final bool isNoteCard;
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: DurationConstant.duration500(),
      transitionBuilder: (child, anim) => CustomRotationAnimation(
        anim: anim,
        child: child,
      ),
      child: query
          ? Icon(
              size: SizeConstant(context).width055,
              Icons.keyboard_arrow_up_rounded,
              key: const ValueKey('openArrow'),
              color: isNoteCard
                  ? (context.watch<HomeViewProvider>().isSwitch
                      ? Color(item!.backgroundColor.hexColor).toDynamicColor
                      : context.watch<ThemeNotifier>().bottomAppBarIcon)
                  : Theme.of(context).listTileTheme.iconColor,
            )
          : Icon(
              size: SizeConstant(context).width055,
              Icons.keyboard_arrow_down_rounded,
              key: const ValueKey('closeArrow'),
              color: isNoteCard
                  ? (context.watch<HomeViewProvider>().isSwitch
                      ? Color(item!.backgroundColor.hexColor).toDynamicColor
                      : context.watch<ThemeNotifier>().bottomAppBarIcon)
                  : Theme.of(context).listTileTheme.iconColor,
            ),
    );
  }
}
