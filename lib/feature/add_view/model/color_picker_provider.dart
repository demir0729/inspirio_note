import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../product/model/note_model.dart';
import '../../home_view/model/home_provider.dart';

class ColorPickerProvider extends ChangeNotifier {
  ColorPickerProvider(BuildContext context) {
    initProperties(context, null);
  }
  final List<String> hexColor = [
    '#311090',
    '#161d6e',
    '#483d8b',
    '#0b7f9a',
    '#2cd8f7',
    '#33dbcf',
    '#dd2857',
    '#fef5ee',
    '#fce2fb',
    '#fffb85',
    '#768daa',
    '#8f098d',
    '#fbc3fa',
    '#0c0c0c',
    '#ffefd5',
    '#ffc0cb',
    '#b0e0e6',
    '#cd853f',
    '#ffdab9',
    '#db7093',
    '#ffd700',
    '#daa520',
    '#ff8c00',
    '#2f4f4f',
    '#e9967a',
  ];

  void initProperties(BuildContext context, dynamic item) {
    if (item is NoteModel) {
      currentBackColor = item.backgroundColor;
      color = item.color;
    } else {
      currentBackColor = context.read<HomeViewProvider>().currentBackColor;
      color = context.read<HomeViewProvider>().color;
    }
  }

  late String currentBackColor;
  late String color;
  void changeColor(String color, int key) {
    if (key == 0) {
      currentBackColor = color;
    } else {
      this.color = color;
    }
    notifyListeners();
  }
}
