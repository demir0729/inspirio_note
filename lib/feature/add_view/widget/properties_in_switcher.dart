import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/animations/transition_animation.dart';
import '../../../core/init/notifier/theme_notifier.dart';
import '../../../product/enums/img_enum.dart';
import '../../../product/enums/png_enum.dart';
import '../../../product/extension/png_extension.dart';
import '../model/add_note_provider.dart';
import '../model/canvas_picker_provider.dart';
import '../model/color_picker_provider.dart';
import 'note_properties.dart';
import 'properties_widget/canvas_opacity_slider.dart';

class PropertiesInSwitcher extends StatelessWidget {
  const PropertiesInSwitcher({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: context.watch<AddViewProvider>().currentLocale,
      builder: (context, value, child) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) =>
            CustomFadeAnimation(anim: anim, child: child),
        child: value != 'null'
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    width: w * 0.8,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      elevation: 8,
                      color: context
                          .watch<ThemeNotifier>()
                          .mainThemeLayerColor
                          .withOpacity(0.8),
                      child: value == 'removeCanvas'
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.02),
                                  onPressed: () {
                                    context
                                        .read<CanvasPickerProvider>()
                                        .changeCanvas(ImgItems.TRANS);
                                  },
                                  icon: Image.asset(
                                    PngItems.REMOVEIMG.getItem,
                                    width: w * 0.05,
                                    color: context
                                        .watch<ThemeNotifier>()
                                        .contentTextColor,
                                  ),
                                ),
                                IconButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: w * 0.02),
                                  onPressed: () {
                                    context
                                        .read<ColorPickerProvider>()
                                        .changeColor('#00FFFFFF', 0);
                                  },
                                  icon: Image.asset(
                                    PngItems.REMOVECLR.getItem,
                                    width: w * 0.05,
                                    color: context
                                        .watch<ThemeNotifier>()
                                        .contentTextColor,
                                  ),
                                ),
                              ],
                            )
                          : const NoteProperties(),
                    ),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: w * 0.1,
                      child: const CanvasOpacitySlider())
                ],
              )
            : null,
      ),
    );
  }
}
