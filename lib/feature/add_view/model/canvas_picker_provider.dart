import 'package:flutter/material.dart';
import 'package:my_notes/product/enums/img_enum.dart';
import 'package:provider/provider.dart';

import '../../../product/model/note_model.dart';
import '../../home_view/model/home_provider.dart';

class CanvasPickerProvider extends ChangeNotifier {
  CanvasPickerProvider(BuildContext context) {
    initProperties(context, null);
  }
  final List<String> canvas = [
    ImgItems.MAX.name,
    ImgItems.NICK.name,
    ImgItems.ANDREA.name,
    ImgItems.ANNIE.name,
    ImgItems.BRIAN.name,
    ImgItems.FILIP.name,
    ImgItems.FIRE.name,
    ImgItems.FRANTISEK.name,
    ImgItems.IVANA.name,
    ImgItems.OCEAN.name,
    ImgItems.PATRICK.name,
    ImgItems.SILAS.name,
    ImgItems.SOLEN.name,
    ImgItems.WATER.name,
  ];

  void initProperties(BuildContext context, dynamic item) {
    if (item is NoteModel) {
      currentCanvas = item.canvas;
    } else {
      currentCanvas = context.read<HomeViewProvider>().currentCanvas.name;
    }
  }

  late String currentCanvas;

  void changeCanvas(ImgItems canvas) {
    currentCanvas = canvas.name;
    notifyListeners();
  }
}
