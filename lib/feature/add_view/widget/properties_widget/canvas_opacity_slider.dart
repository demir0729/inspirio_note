import 'package:flutter/material.dart';
import 'package:my_notes/product/constant/color_constants.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../model/add_note_provider.dart';

class CanvasOpacitySlider extends StatelessWidget {
  const CanvasOpacitySlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.watch<AddViewProvider>().blendOpacity,
      builder: (context, value, child) => Visibility(
        visible: true,
        child: SfSlider.vertical(
          activeColor: ColorConstants.whiteLight,
          value: value * 100,
          max: 100,
          min: 0,
          onChanged: (value) {
            context.read<AddViewProvider>().changeBlendOpacity(value);
          },
        ),
      ),
    );
  }
}
