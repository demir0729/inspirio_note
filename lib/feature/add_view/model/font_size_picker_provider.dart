import 'package:flutter/material.dart';
import 'package:my_notes/product/model/note_model.dart';
import 'package:provider/provider.dart';

import '../../home_view/model/home_provider.dart';

class FontSizePickerProvider extends ChangeNotifier {
  final List<double> fontResponsiveSizes = [
    0.04,
    0.05,
    0.06,
    0.07,
    0.08,
    0.09,
    0.10,
    0.11,
    0.12,
    0.13,
    0.14,
  ];

  void initProperties(BuildContext context, dynamic item) {
    currentSize = ValueNotifier(0.04);
    if (item is NoteModel) {
      currentSize.value = item.fontSize;
    } else {
      Future.microtask(() {
        if (context.read<HomeViewProvider>().isTicket) {
          currentSize.value = context.read<HomeViewProvider>().fontSize;
        } else {
          currentSize.value = context.read<HomeViewProvider>().fontSize *
              MediaQuery.of(context).size.width;
        }
      });
    }
  }

  late ValueNotifier<double> currentSize;

  void changeSize(double value) {
    currentSize.value = value;
  }
}
