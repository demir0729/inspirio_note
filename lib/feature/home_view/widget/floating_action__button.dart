import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/animations/transition_animation.dart';
import '../../../core/init/notifier/theme_notifier.dart';
import '../../../core/widgets/custom_button/floating_action_button.dart';
import '../../../product/constant/duration_constant.dart';
import '../../../product/constant/size_constant.dart';
import '../../../product/enums/svg_enum.dart';
import '../../../product/extension/svg_extension.dart';
import '../../../product/routes/app_router.dart';
import '../model/home_provider.dart';

class SpesificFloatingActionButton extends StatelessWidget {
  const SpesificFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConstant(context).width15,
      child: FittedBox(
        child: CustomFloatingActionButton(
          onPressed: () async {
            if (context.read<HomeViewProvider>().longPressed) {
              context.read<HomeViewProvider>().longPressedOff();
            } else {
              await context.read<HomeViewProvider>().getNoteProperties(context);
              if (context.mounted) {
                context.router.replace(AddNoteRoute(item: null));
              }
            }
          },
          child: AnimatedSwitcher(
            transitionBuilder: (child, anim) =>
                CustomFadeAnimation(anim: anim, child: child),
            duration: DurationConstant.duration500(),
            child: context.watch<HomeViewProvider>().longPressed
                ? const Icon(
                    Icons.reply_outlined,
                    key: ValueKey('icon2'),
                  )
                : SvgPicture.asset(
                    SvgItems.quill.getItem,
                    colorFilter: ColorFilter.mode(
                      context.watch<ThemeNotifier>().mainThemeLayerColor,
                      BlendMode.srcIn,
                    ),
                    width: 26,
                    height: 26,
                  ),
          ),
        ),
      ),
    );
  }
}
