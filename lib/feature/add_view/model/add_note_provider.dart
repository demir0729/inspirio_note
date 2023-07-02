import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/init/cache/abstract_manager.dart';
import '../../../core/init/cache/home_note_cache.dart';
import '../../../core/init/cache/map_cache.dart';
import '../../../product/constant/id_and_key_constant.dart';
import '../../../product/enums/views_name_enum.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/lang/locale_keys.g.dart';
import '../../../product/model/note_model.dart';
import '../../home_view/model/home_provider.dart';
import 'blend_mode_picker_provider.dart';
import 'canvas_picker_provider.dart';
import 'color_picker_provider.dart';
import 'font_family_picker_provider.dart';
import 'font_height_picker_provider.dart';
import 'font_size_picker_provider.dart';

class AddViewProvider extends ChangeNotifier {
  AddViewProvider(BuildContext context) {
    propertiesCache = MapItemCache(itemBoxkey: IdAndKeyConstant.mapItemsBoxKey);
    homeCache = HomeNoteCache(itemBoxkey: IdAndKeyConstant.itemsBoxKey);

    init();
    initProperties(context, null);
  }
  dynamic data;
  late final IGeneralCacheManager<Map<dynamic, dynamic>> propertiesCache;
  late final IGeneralCacheManager<NoteModel> homeCache;

  late bool isTicket;
  late bool isTextAlignCenter;
  late String noteTitle;
  late TextEditingController contentController;
  late TextEditingController titleController;
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  bool isTitle = false;

  List? currentPropertiesList;
  late ValueNotifier<String> currentLocale;

  late ValueNotifier<double> blendOpacity;

  init() async {
    await propertiesCache.init();
    await homeCache.init();
  }

  void initProperties(BuildContext context, dynamic item) {
    isTicket = context.read<HomeViewProvider>().isTicket;
    currentLocale = ValueNotifier('null');
    blendOpacity = ValueNotifier(1);
    contentController = TextEditingController();
    titleController = TextEditingController();
    if (item is NoteModel) {
      isTextAlignCenter = item.isTextCenter;
      noteTitle = item.title == ''
          ? LocaleKeys.addTitle.locale
          : (item.title ?? LocaleKeys.addTitle.locale);
      contentController.text = item.content ?? '';
      titleController.text = item.title ?? '';
      blendOpacity.value = item.opacity;
    } else {
      noteTitle = LocaleKeys.addTitle.locale;
      isTextAlignCenter = context.read<HomeViewProvider>().isTextAlignCenter;
      blendOpacity.value = context.read<HomeViewProvider>().blendOpacity;
    }
  }

  void changeBlendOpacity(double value) {
    blendOpacity.value = value / 100;
  }

  void properties(BuildContext context, String currentProperties) {
    switch (currentProperties) {
      case 'removeCanvas':
        currentPropertiesList = context.read<ColorPickerProvider>().hexColor;
        currentLocale.value = 'removeCanvas';
        break;
      case 'backgroundColor':
        currentPropertiesList = context.read<ColorPickerProvider>().hexColor;
        currentLocale.value = 'backgroundColor';
        break;
      case 'canvas':
        currentPropertiesList = context.read<CanvasPickerProvider>().canvas;
        currentLocale.value = 'canvas';
        break;
      case 'blendMode':
        currentPropertiesList =
            context.read<BlendModePickerProvider>().blendMode;
        currentLocale.value = 'blendMode';
        break;
      case 'color':
        currentPropertiesList = context.read<ColorPickerProvider>().hexColor;
        currentLocale.value = 'color';
        break;
      case 'fontSize':
        currentPropertiesList =
            context.read<FontSizePickerProvider>().fontResponsiveSizes;
        currentLocale.value = 'fontSize';
        break;
      case 'fontHeight':
        currentPropertiesList =
            context.read<FontHeightPickerProvider>().heights;
        currentLocale.value = 'fontHeight';
        break;
      case 'fontFamily':
        currentPropertiesList =
            context.read<FontFamilyPickerProvider>().fontFamilies;
        currentLocale.value = 'fontFamily';
        break;
      case 'null':
        currentLocale.value = 'null';
        break;
    }
  }

  void selectedTicket() {
    if (isTicket) {
      isTicket = false;
      notifyListeners();
      return;
    }
    isTicket = true;
    notifyListeners();
  }

  Future<void> saveProperties(BuildContext context) async {
    Map<String, dynamic> properties = {
      'isTicket': isTicket,
      'isTextAlignCenter': isTextAlignCenter,
      'backgroundColor': context.read<ColorPickerProvider>().currentBackColor,
      'color': context.read<ColorPickerProvider>().color,
      'fontSize': context.read<FontSizePickerProvider>().currentSize.value,
      'fontFamily': context.read<FontFamilyPickerProvider>().currentFamily,
      'canvas': context.read<CanvasPickerProvider>().currentCanvas,
      'blendMode': context.read<BlendModePickerProvider>().currentBlendMode,
      'fontHeight': context.read<FontHeightPickerProvider>().currentHeight,
      'opacity': blendOpacity.value,
    };
    await propertiesCache.addItem({'noteAreaProperties': properties});
  }

  void textAlignCenter() {
    isTextAlignCenter = !isTextAlignCenter;
    notifyListeners();
  }

  void openAndEditTextfield() {
    isTitle = true;
    titleFocusNode.requestFocus();
    notifyListeners();
  }

  void saveAndCloseTextfield(BuildContext context) {
    noteTitle = titleController.text;
    if (isTitle == false) return;
    isTitle = !isTitle;
    notifyListeners();
  }

  Future<void> saveNotes(BuildContext context, dynamic oldItem) async {
    final now = DateTime.now();
    final dateFormat = DateFormat(LocaleKeys.date.locale);
    final date = dateFormat.format(now);
    final fontSize = context.read<FontSizePickerProvider>().currentSize.value;

    if (oldItem is NoteModel) {
      updateOldItem(context, oldItem, date, fontSize);
    } else {
      addNewItem(context, date, fontSize);
    }
    contentController.clear();
    titleController.clear();
    noteTitle = LocaleKeys.addTitle.locale;
    context.read<HomeViewProvider>().itemsListGenerate(ViewsName.HOME);
    context.read<HomeViewProvider>().getSwitchState();
    saveAndCloseTextfield(context);
    notifyListeners();
  }

  void updateOldItem(
    BuildContext context,
    NoteModel oldItem,
    String date,
    double fontSize,
  ) {
    homeCache.addItem(
      NoteModel(
        date: date,
        title: titleController.text,
        content: contentController.text,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        isFavorite: oldItem.isFavorite,
        isHistory: false,
        isTextCenter: isTextAlignCenter,
        backgroundColor: context.read<ColorPickerProvider>().currentBackColor,
        canvas: context.read<CanvasPickerProvider>().currentCanvas,
        blendMode: context.read<BlendModePickerProvider>().currentBlendMode,
        color: context.read<ColorPickerProvider>().color,
        fontSize: fontSize,
        fontHeight: context.read<FontHeightPickerProvider>().currentHeight,
        fontFamily: context.read<FontFamilyPickerProvider>().currentFamily,
        timestamp: DateTime.now().toString(),
        opacity: context.read<AddViewProvider>().blendOpacity.value,
      ),
    );
    homeCache.deleteItem(oldItem.id);
  }

  Future<void> addNewItem(
      BuildContext context, String date, double fontSize) async {
    if (!(contentController.text.isEmpty && titleController.text.isEmpty)) {
      NoteModel newItem = NoteModel(
        date: date,
        title: titleController.text,
        content: contentController.text,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        isFavorite: false,
        isHistory: false,
        isTextCenter: isTextAlignCenter,
        backgroundColor: context.read<ColorPickerProvider>().currentBackColor,
        canvas: context.read<CanvasPickerProvider>().currentCanvas,
        blendMode: context.read<BlendModePickerProvider>().currentBlendMode,
        color: context.read<ColorPickerProvider>().color,
        fontSize: fontSize,
        fontHeight: context.read<FontHeightPickerProvider>().currentHeight,
        fontFamily: context.read<FontFamilyPickerProvider>().currentFamily,
        timestamp: DateTime.now().toString(),
        opacity: context.read<AddViewProvider>().blendOpacity.value,
      );
      await context.read<HomeViewProvider>().homeCache.addItem(newItem);
    }
  }
}
