import 'package:flutter/material.dart';
import 'package:my_notes/product/enums/icon_enum.dart';

extension IconItemsExtension on IconItems {
  String _path() {
    switch (this) {
      case IconItems.FOX:
        return 'fox_icon';
      case IconItems.OWL:
        return 'owl_icon';
      case IconItems.RAVEN:
        return 'raven_icon';
      case IconItems.PERSON:
        return 'person_2';
    }
  }

  String get getIcon => 'assets/icons/${_path()}.png';
}

extension FlutterIconItemsExtension on FlutterIconItems {
  IconData? _getIcon() {
    switch (this) {
      case FlutterIconItems.PERSON:
        return Icons.person_2;
    }
  }

  Icon get flutterIcon => Icon(_getIcon());
}
