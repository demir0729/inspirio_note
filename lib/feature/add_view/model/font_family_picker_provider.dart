import 'package:flutter/material.dart';
import 'package:my_notes/product/constant/font_family_constant.dart';
import 'package:my_notes/product/model/note_model.dart';
import 'package:provider/provider.dart';

import '../../home_view/model/home_provider.dart';

class FontFamilyPickerProvider extends ChangeNotifier {
  FontFamilyPickerProvider(BuildContext context) {
    initProperties(context, null);
  }
  final List<String> fontFamilies = [
    FontFamilyConstant.amatic,
    FontFamilyConstant.walkway,
    FontFamilyConstant.sourceSans3,
    FontFamilyConstant.gotham,
    FontFamilyConstant.humanCrush,
    FontFamilyConstant.cinzel,
    FontFamilyConstant.cinzelDecorative,
    FontFamilyConstant.barlowSemiCondensed,
    FontFamilyConstant.merriweatherSans,
    FontFamilyConstant.school,
    FontFamilyConstant.whoAreYou,
    FontFamilyConstant.newRocker,
    FontFamilyConstant.rubikPixels,
    FontFamilyConstant.beachplease,
    FontFamilyConstant.angryMonsters,
    FontFamilyConstant.changeYourName,
    FontFamilyConstant.extraoin,
    FontFamilyConstant.galiver,
    FontFamilyConstant.gamera,
    FontFamilyConstant.rubikWetPaint,
    FontFamilyConstant.kidStories,
  ];

  void initProperties(BuildContext context, dynamic item) {
    if (item is NoteModel) {
      currentFamily = item.fontFamily;
    } else {
      currentFamily = context.read<HomeViewProvider>().fontFamily;
    }
  }

  late String currentFamily;

  void changeFamily(String family) {
    currentFamily = family;
    notifyListeners();
  }
}
