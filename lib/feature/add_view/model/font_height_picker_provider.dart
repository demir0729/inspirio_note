import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../product/model/note_model.dart';
import '../../home_view/model/home_provider.dart';

class FontHeightPickerProvider extends ChangeNotifier {
  FontHeightPickerProvider(BuildContext context) {
    initProperties(context, null);
  }
  final List<double> heights = [1.5, 1.65, 2.0, 2.5, 2.65, 3.0];

  void initProperties(BuildContext context, dynamic item) {
    if (item is NoteModel) {
      currentHeight = item.fontHeight;
    } else {
      currentHeight = context.read<HomeViewProvider>().fontHeight;
    }
  }

  late double currentHeight;

  void changeHeight(double height) {
    currentHeight = height;
    notifyListeners();
  }
}
