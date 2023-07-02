import 'package:flutter/material.dart';
import '../model/add_note_provider.dart';
import '../model/blend_mode_picker_provider.dart';
import '../../../product/extension/img_extension.dart';
import '../../../product/extension/string_extension.dart';
import 'package:provider/provider.dart';

import '../model/canvas_picker_provider.dart';
import '../model/color_picker_provider.dart';

class CanvasImage extends StatelessWidget {
  const CanvasImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.watch<AddViewProvider>().blendOpacity,
      builder: (context, value, child) => Image.asset(
        context
            .watch<CanvasPickerProvider>()
            .currentCanvas
            .convertToImgItems
            .getItems,
        key: ValueKey(context.watch<CanvasPickerProvider>().currentCanvas),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.cover,
        colorBlendMode: context
            .watch<BlendModePickerProvider>()
            .currentBlendMode
            .convertToBlendMode,
        color: Color(
                context.watch<ColorPickerProvider>().currentBackColor.hexColor)
            .withOpacity(value),
      ),
    );
  }
}
