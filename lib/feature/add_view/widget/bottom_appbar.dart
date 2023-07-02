import 'package:flutter/material.dart';
import 'picker_button_widget.dart';
import '../../../product/extension/png_extension.dart';
import '../../../product/extension/string_extension.dart';
import 'package:provider/provider.dart';

import '../../../core/init/notifier/theme_notifier.dart';
import '../../../core/widgets/flushbar_widget.dart';
import '../../../product/constant/size_constant.dart';
import '../../../product/enums/img_enum.dart';
import '../../../product/enums/png_enum.dart';
import '../../../product/lang/locale_keys.g.dart';
import '../model/add_note_provider.dart';
import '../model/canvas_picker_provider.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.watch<AddViewProvider>().currentLocale,
      builder: (context, value, child) => Container(
        height: SizeConstant(context).height1,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.keyboard_arrow_left_rounded,
              color: context.watch<ThemeNotifier>().bottomAppBarIcon,
              size: SizeConstant(context).width05,
            ),
            SizedBox(
              width: SizeConstant(context).width7,
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    PickerButton(
                      onPressed: () {
                        if (value == 'canvas') {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'null');
                        } else {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'canvas');
                        }
                      },
                      png: PngItems.IMG.getItem,
                    ),
                    PickerButton(
                      onPressed: () {
                        if (value == 'backgroundColor') {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'null');
                        } else {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'backgroundColor');
                        }
                      },
                      png: PngItems.BACKCLR.getItem,
                    ),
                    PickerButton(
                      onPressed: () {
                        if (context
                                .read<CanvasPickerProvider>()
                                .currentCanvas ==
                            ImgItems.TRANS.name) {
                          customFlushbar(
                              context, LocaleKeys.selectCanvas.locale);
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'null');
                          return;
                        }
                        if (value == 'blendMode') {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'null');
                        } else {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'blendMode');
                        }
                      },
                      png: PngItems.MAGIC.getItem,
                    ),
                    PickerButton(
                      onPressed: () {
                        if (value == 'color') {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'null');
                        } else {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'color');
                        }
                      },
                      png: PngItems.COLOR.getItem,
                    ),
                    PickerButton(
                      onPressed: () {
                        if (value == 'fontSize') {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'null');
                        } else {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'fontSize');
                        }
                      },
                      png: PngItems.SIZE.getItem,
                    ),
                    PickerButton(
                      onPressed: () {
                        if (value == 'fontHeight') {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'null');
                        } else {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'fontHeight');
                        }
                      },
                      png: PngItems.HEIGHT.getItem,
                    ),
                    PickerButton(
                      onPressed: () {
                        if (value == 'fontFamily') {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'null');
                        } else {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'fontFamily');
                        }
                      },
                      png: PngItems.FAMILY.getItem,
                    ),
                    PickerButton(
                      onPressed: () {
                        context.read<AddViewProvider>().textAlignCenter();
                        context
                            .read<AddViewProvider>()
                            .properties(context, 'null');
                      },
                      png: context.watch<AddViewProvider>().isTextAlignCenter
                          ? PngItems.CENTER.getItem
                          : PngItems.LEFT.getItem,
                    ),
                    PickerButton(
                      onPressed: () {
                        if (value == 'removeCanvas') {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'null');
                        } else {
                          context
                              .read<AddViewProvider>()
                              .properties(context, 'removeCanvas');
                        }
                      },
                      png: PngItems.REMOVEIMG.getItem,
                    ),
                  ],
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: context.watch<ThemeNotifier>().bottomAppBarIcon,
              size: SizeConstant(context).width05,
            ),
          ],
        ),
      ),
    );
  }
}
