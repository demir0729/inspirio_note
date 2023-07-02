import 'package:diacritic/diacritic.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/product/enums/img_enum.dart';
import 'package:my_notes/product/lang/locale_keys.g.dart';

extension StringLocalitazion on String {
  String get locale => this.tr();
  int get hexColor => int.parse(replaceFirst('#', '0xFF'));
  String toEditingTitleShort(double w) {
    int maxChar = 0;
    if (w <= 325) {
      maxChar = 7;
    } else if (w <= 365) {
      maxChar = 10;
    } else if (w < 400) {
      maxChar = 13;
    } else {
      maxChar = 15;
    }
    if (this == LocaleKeys.addTitle.locale) return this;
    if (length > maxChar) {
      return substring(0, maxChar).replaceRange(maxChar, maxChar, '...');
    } else if (this == '') {
      return LocaleKeys.addTitle.locale;
    } else if (isEmpty) {
      return LocaleKeys.addTitle.locale;
    } else {
      return this;
    }
  }

  String toCardShort(double w, bool isTitle, bool isCardOpen) {
    int titleMaxChar = 10;
    int contentMaxChar = 31;
    if (w < 325) {
      titleMaxChar = 14;
      contentMaxChar = 29;
    } else if (w < 365) {
      titleMaxChar = 15;
      contentMaxChar = 35;
    } else if (w < 385) {
      titleMaxChar = 20;
      contentMaxChar = 43;
    }
    if (isTitle) {
      if (this == '') {
        return LocaleKeys.nameless.locale;
      } else {
        if (length > titleMaxChar) {
          if (isCardOpen) {
            return this;
          } else {
            return replaceRange(titleMaxChar, null, '...');
          }
        } else {
          return this;
        }
      }
    } else {
      if (length > contentMaxChar) {
        if (isCardOpen) {
          return this;
        } else {
          return replaceRange(contentMaxChar, null, '...');
        }
      } else {
        return this;
      }
    }
  }

  String get removeSpecialCharacter => removeDiacritics(toLowerCase());

  Image get imageNetwork => Image.network(this);
  Image imageAsset(BlendMode mode, Color color, double width) => Image.asset(
        'assets/img/$this.jpg',
        colorBlendMode: mode,
        color: color,
        fit: BoxFit.cover,
        width: width,
      );
  ImgItems get convertToImgItems {
    switch (this) {
      case 'ANDREA':
        return ImgItems.ANDREA;
      case 'ANNIE':
        return ImgItems.ANNIE;
      case 'BRIAN':
        return ImgItems.BRIAN;
      case 'FILIP':
        return ImgItems.FILIP;
      case 'FIRE':
        return ImgItems.FIRE;
      case 'FRANTISEK':
        return ImgItems.FRANTISEK;
      case 'IVANA':
        return ImgItems.IVANA;
      case 'MAX':
        return ImgItems.MAX;
      case 'NICK':
        return ImgItems.NICK;
      case 'OCEAN':
        return ImgItems.OCEAN;
      case 'PATRICK':
        return ImgItems.PATRICK;
      case 'SILAS':
        return ImgItems.SILAS;
      case 'SOLEN':
        return ImgItems.SOLEN;
      case 'WATER':
        return ImgItems.WATER;
      case 'TRANS':
        return ImgItems.TRANS;
    }
    return ImgItems.FIRE;
  }

  BlendMode get convertToBlendMode {
    switch (this) {
      case 'color':
        return BlendMode.color;
      case 'colorBurn':
        return BlendMode.colorBurn;
      case 'colorDodge':
        return BlendMode.colorDodge;
      case 'darken':
        return BlendMode.darken;
      case 'difference':
        return BlendMode.difference;
      case 'exclusion':
        return BlendMode.exclusion;
      case 'hardLight':
        return BlendMode.hardLight;
      case 'hue':
        return BlendMode.hue;
      case 'lighten':
        return BlendMode.lighten;
      case 'multiply':
        return BlendMode.multiply;
      case 'overlay':
        return BlendMode.overlay;
      case 'plus':
        return BlendMode.plus;
      case 'saturation':
        return BlendMode.saturation;
      case 'screen':
        return BlendMode.screen;
      case 'softLight':
        return BlendMode.softLight;
    }
    return BlendMode.clear;
  }
}
