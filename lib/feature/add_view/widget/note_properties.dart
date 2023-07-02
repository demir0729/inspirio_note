import 'package:flutter/material.dart';
import '../model/add_note_provider.dart';
import '../model/font_size_picker_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/init/notifier/theme_notifier.dart';
import '../../../product/constant/size_constant.dart';
import '../../../product/extension/string_extension.dart';
import '../model/blend_mode_picker_provider.dart';
import '../model/canvas_picker_provider.dart';
import '../model/color_picker_provider.dart';
import '../model/font_family_picker_provider.dart';
import '../model/font_height_picker_provider.dart';

class NoteProperties extends StatelessWidget {
  const NoteProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.watch<AddViewProvider>().currentLocale,
      builder: (context, value, child) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount:
            context.watch<AddViewProvider>().currentPropertiesList?.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: InkWell(
              borderRadius: BorderRadius.circular(50),
              splashColor: const Color.fromARGB(199, 170, 170, 170),
              onTap: () {
                switch (value) {
                  case 'backgroundColor':
                    context.read<ColorPickerProvider>().changeColor(
                        context
                            .read<AddViewProvider>()
                            .currentPropertiesList?[index],
                        0);
                    break;
                  case 'canvas':
                    context.read<CanvasPickerProvider>().changeCanvas(context
                        .read<AddViewProvider>()
                        .currentPropertiesList![index]
                        .toString()
                        .convertToImgItems);
                    break;
                  case 'blendMode':
                    context.read<BlendModePickerProvider>().changeBlendMode(
                        context
                            .read<AddViewProvider>()
                            .currentPropertiesList![index]
                            .toString()
                            .convertToBlendMode);
                    break;
                  case 'color':
                    context.read<ColorPickerProvider>().changeColor(
                        context
                            .read<AddViewProvider>()
                            .currentPropertiesList![index],
                        1);
                    break;
                  case 'fontSize':
                    context.read<FontSizePickerProvider>().changeSize(
                          context
                                  .read<AddViewProvider>()
                                  .currentPropertiesList?[index] *
                              MediaQuery.of(context).size.width,
                        );

                    break;
                  case 'fontHeight':
                    context.read<FontHeightPickerProvider>().changeHeight(
                        context
                            .read<AddViewProvider>()
                            .currentPropertiesList?[index]);

                    break;
                  case 'fontFamily':
                    context.read<FontFamilyPickerProvider>().changeFamily(
                        context
                            .read<AddViewProvider>()
                            .currentPropertiesList?[index]);
                    break;
                }
              },
              child: _currentPropertiesWidget(
                  context,
                  context.watch<AddViewProvider>().currentPropertiesList!,
                  index,
                  value),
            ),
          );
        },
      ),
    );
  }

  Widget _currentPropertiesWidget(
      BuildContext context, List<dynamic> items, int index, String locale) {
    switch (locale) {
      case 'backgroundColor':
        return Icon(
          Icons.circle,
          color: Color(items[index].toString().hexColor),
          size: SizeConstant(context).width1,
        );
      case 'canvas':
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: items[index].toString().imageAsset(BlendMode.color,
              Colors.transparent, (SizeConstant(context).width1)),
        );
      case 'blendMode':
        return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                context.watch<CanvasPickerProvider>().currentCanvas.imageAsset(
                      items[index].toString().convertToBlendMode,
                      Color(context
                          .watch<ColorPickerProvider>()
                          .currentBackColor
                          .hexColor),
                      (SizeConstant(context).width1),
                    ));
      case 'color':
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstant(context).width01,
          ),
          child: Center(
            child: Text(
              'Ab',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: SizeConstant(context).width05,
                    color: Color(items[index].toString().hexColor),
                    fontFamily: context
                        .watch<FontFamilyPickerProvider>()
                        .currentFamily
                        .split('-')
                        .first,
                  ),
            ),
          ),
        );
      case 'fontSize':
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstant(context).width01,
          ),
          child: Center(
            child: Text(
              (items[index] * MediaQuery.of(context).size.width)
                  .toString()
                  .substring(0, 2),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: context.watch<ThemeNotifier>().contentTextColor,
                    fontSize: SizeConstant(context).width05,
                  ),
            ),
          ),
        );
      case 'fontHeight':
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstant(context).width01,
          ),
          child: Center(
            child: Text(
              '${items[index]}',
              style: TextStyle(
                fontSize: SizeConstant(context).width05,
              ),
            ),
          ),
        );
      case 'fontFamily':
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstant(context).width01,
          ),
          child: Center(
            child: Text(
              'Ab',
              style: TextStyle(
                fontSize: SizeConstant(context).width05,
                fontFamily: items[index].split('-').first,
                color: context.watch<ThemeNotifier>().contentTextColor,
              ),
            ),
          ),
        );
    }
    return Container();
  }
}
