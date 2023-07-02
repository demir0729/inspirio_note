import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../feature/home_view/model/home_provider.dart';
import '../../../product/constant/color_constants.dart';
import '../../../product/constant/duration_constant.dart';
import '../../../product/extension/dynamic_color_extension.dart';
import '../../animations/transition_animation.dart';

class PopupIcon extends StatelessWidget {
  const PopupIcon({
    super.key,
    required this.toggle,
    required this.alignment,
    required this.size,
    required this.svgItem,
    required this.onTap,
    required this.color,
    required this.isComeOpened,
  });
  final bool toggle;
  final Alignment alignment;
  final double size;
  final String svgItem;
  final Function() onTap;
  final Color color;
  final bool isComeOpened;
  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      duration: toggle
          ? DurationConstant.duration275()
          : DurationConstant.duration875(),
      alignment: alignment,
      curve: toggle ? Curves.easeIn : Curves.easeOutCirc,
      child: AnimatedContainer(
        duration: DurationConstant.duration275(),
        curve: toggle ? Curves.easeIn : Curves.easeOut,
        width: 9.w,
        height: 5.h,
        child: AnimatedSwitcher(
          reverseDuration: DurationConstant.duration275(),
          duration: DurationConstant.duration1000(),
          transitionBuilder: (child, anim) =>
              CustomFadeAnimation(anim: anim, child: child),
          child: !toggle
              ? IconButton(
                  onPressed: context.read<HomeViewProvider>().longPressed
                      ? null
                      : onTap,
                  icon: SvgPicture.asset(
                    svgItem,
                    width: size,
                    colorFilter: ColorFilter.mode(
                      isComeOpened
                          ? color.toDynamicColor
                          : (context.watch<HomeViewProvider>().isSwitch
                              ? color.toDynamicColor
                              : ColorConstants.ravenBlack),
                      BlendMode.srcIn,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}
