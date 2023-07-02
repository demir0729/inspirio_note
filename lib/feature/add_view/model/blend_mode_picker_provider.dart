import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../product/model/note_model.dart';
import '../../home_view/model/home_provider.dart';

class BlendModePickerProvider extends ChangeNotifier {
  BlendModePickerProvider(BuildContext context) {
    initProperties(context, null);
  }
  final List<String> blendMode = [
    BlendMode.colorBurn.name,
    BlendMode.multiply.name,
    BlendMode.darken.name,
    BlendMode.overlay.name,
    BlendMode.softLight.name,
    BlendMode.hue.name,
    BlendMode.color.name,
    BlendMode.colorDodge.name,
    BlendMode.plus.name,
    BlendMode.screen.name,
    BlendMode.lighten.name,
    BlendMode.exclusion.name,
    BlendMode.difference.name,
    BlendMode.hardLight.name,
    BlendMode.saturation.name,
  ];

  void initProperties(BuildContext context, dynamic item) {
    if (item is NoteModel) {
      currentBlendMode = item.blendMode;
    } else {
      currentBlendMode = context.read<HomeViewProvider>().currentBlendMode.name;
    }
  }

  late String currentBlendMode;

  void changeBlendMode(BlendMode blendMode) {
    currentBlendMode = blendMode.name;
    notifyListeners();
  }
}
