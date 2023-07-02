import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../product/extension/dynamic_color_extension.dart';
import '../../../product/extension/string_extension.dart';
import '../model/add_note_provider.dart';
import '../model/color_picker_provider.dart';
import '../model/font_family_picker_provider.dart';
import '../model/font_height_picker_provider.dart';
import '../model/font_size_picker_provider.dart';

class NoteAreaTextfield extends StatelessWidget {
  const NoteAreaTextfield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.watch<FontSizePickerProvider>().currentSize,
      builder: (context, value, child) => TextField(
        scrollPhysics: const BouncingScrollPhysics(),
        cursorColor: Color(
                context.watch<ColorPickerProvider>().currentBackColor.hexColor)
            .toDynamicColor,
        textAlign: context.watch<AddViewProvider>().isTextAlignCenter
            ? TextAlign.center
            : TextAlign.start,
        focusNode: context.watch<AddViewProvider>().contentFocusNode,
        onTap: () {
          context.read<AddViewProvider>().saveAndCloseTextfield(context);

          context.read<AddViewProvider>().properties(context, 'null');
        },
        controller: context.watch<AddViewProvider>().contentController,
        style: TextStyle(
          fontFamily: context
              .watch<FontFamilyPickerProvider>()
              .currentFamily
              .split('-')
              .first,
          fontSize: value,
          color: Color(context.watch<ColorPickerProvider>().color.hexColor),
          height: context.watch<FontHeightPickerProvider>().currentHeight,
        ),
        autofocus: true,
        keyboardType: TextInputType.multiline,
        maxLines: 50,
        decoration: const InputDecoration(
          constraints: BoxConstraints(minHeight: double.infinity),
          contentPadding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
