import 'package:flutter/material.dart';

import '../../../core/init/cache/abstract_manager.dart';
import '../../../core/init/cache/home_note_cache.dart';
import '../../../core/init/cache/map_cache.dart';
import '../../../product/constant/font_family_constant.dart';
import '../../../product/constant/id_and_key_constant.dart';
import '../../../product/enums/img_enum.dart';
import '../../../product/enums/views_name_enum.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/lang/locale_keys.g.dart';
import '../../../product/model/note_model.dart';

class HomeViewProvider extends ChangeNotifier {
  HomeViewProvider() {
    init();
  }
  late final IGeneralCacheManager<NoteModel> homeCache;
  late final IGeneralCacheManager<Map> appInfoCache;
  List<NoteModel> items = [];
  List<NoteModel> selectedItems = [];
  late List<bool> cardOpenList;
  late List<bool> cardSelectList;
  bool longPressed = false;
  bool openCardIconVisibility = false;
  bool isthemeContainer = false;
  bool isSwitch = true;
  TextEditingController searchController = TextEditingController();

  //*note properties
  bool isTicket = false;
  String currentBackColor = '#dfe6e0';
  ImgItems currentCanvas = ImgItems.TRANS;
  BlendMode currentBlendMode = BlendMode.multiply;
  String color = '#2f4f4f';
  String fontFamily = FontFamilyConstant.gotham;
  double fontSize = 0.04;
  double fontHeight = 1.5;
  bool isTextAlignCenter = false;
  double blendOpacity = 1.0;

  Future<void> init() async {
    homeCache = HomeNoteCache(itemBoxkey: IdAndKeyConstant.itemsBoxKey);
    appInfoCache = MapItemCache(itemBoxkey: IdAndKeyConstant.mapItemsBoxKey);

    await appInfoCache.init();
    await homeCache.init();
    await itemsListGenerate(ViewsName.HOME);
    getSwitchState();
  }

  Future<void> itemsListGenerate(Enum whereComeFrom) async {
    switch (whereComeFrom) {
      case ViewsName.HOME:
        searchController.text = '';
        items = homeCache
            .getAllItems()
            .where((element) => element.isHistory == false)
            .toList();
        break;

      case ViewsName.FAVORITE:
        items = homeCache
            .getAllItems()
            .where((element) => element.isFavorite)
            .toList();
        items.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        break;

      case ViewsName.HISTORY:
        items = homeCache
            .getAllItems()
            .where((element) => element.isHistory == true)
            .toList();
        items.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        break;
      //  }
    }
    cardOpenList = List.generate(items.length, (index) => false);
    cardSelectList = List.generate(items.length, (index) => false);
    notifyListeners();
  }

  Future<void> totalValuesInItems(String value) async {
    if (value.isEmpty) {
      itemsListGenerate(ViewsName.HOME);
      return;
    }
    final findInMainItems = homeCache.getAllItems().where((e) {
      String contentAndTitle =
          '${e.content ?? ''}${(e.title) == '' ? LocaleKeys.nameless.locale : e.title}';
      return contentAndTitle.removeSpecialCharacter
          .contains(value.removeSpecialCharacter);
    }).toList();
    cardOpenList = List.generate(findInMainItems.length, (index) => false);
    cardSelectList = List.generate(findInMainItems.length, (index) => false);
    items = findInMainItems;
    notifyListeners();
  }

  Future<void> favoriteItemCardState(
      NoteModel item, bool isComeFromFavorite) async {
    if (item.isFavorite) {
      item.isFavorite = false;
      await homeCache.addItem(item);
    } else {
      item.isFavorite = true;
      item.timestamp = DateTime.now().toString();
      await homeCache.addItem(item);
    }

    if (isComeFromFavorite) {
      itemsListGenerate(ViewsName.FAVORITE);
    } else {
      if (searchController.text.isNotEmpty) {
        totalValuesInItems(searchController.text);
      } else {
        itemsListGenerate(ViewsName.HOME);
      }
    }
    notifyListeners();
  }

  void openItemCardStatePro(int index) {
    if (cardOpenList[index] == true) {
      cardOpenList[index] = false;
    } else {
      cardOpenList[index] = true;
    }
    notifyListeners();
  }

  void longPressState(NoteModel item, int index) {
    if (!longPressed) {
      longPressedOn();
      selectedItemState(item, index);
    }
  }

  void onTapState(NoteModel item, int index) {
    if (longPressed) {
      selectedItemState(item, index);
    }

    final containsTrue =
        cardSelectList.where((element) => element == true).toList();

    if (containsTrue.isEmpty) {
      longPressedOff();
    }
  }

  Future<void> addSelectedITemsToHistory() async {
    for (var element in selectedItems) {
      element.isHistory = true;
      element.isFavorite = false;
      element.timestamp = DateTime.now().toString();
      await homeCache.addItem(element);
    }
    await itemsListGenerate(ViewsName.HOME);
    longPressedOff();
  }

  Future<void> selectedItemState(NoteModel item, int index) async {
    if (cardSelectList[index]) {
      cardSelectList[index] = false;
      selectedItems.remove(item);
    } else {
      cardSelectList[index] = true;
      selectedItems.add(item);
    }
    notifyListeners();
  }

  Future<void> restoreItems(NoteModel item, bool isComeFromHistory) async {
    item.isHistory = false;
    await homeCache.addItem(item);
    if (!isComeFromHistory) {
      items = homeCache.getAllItems();
      totalValuesInItems(searchController.text);
    } else {
      itemsListGenerate(ViewsName.HISTORY);
    }
    notifyListeners();
  }

  Future<void> cleaningQuery() async {
    if (selectedItems.isEmpty) {
      for (var element in items) {
        await homeCache.deleteItem(element.id);
      }
    } else {
      for (var element in selectedItems) {
        await homeCache.deleteItem(element.id);
      }
      longPressedOff();
    }
    itemsListGenerate(ViewsName.HISTORY);
    notifyListeners();
  }

  void longPressedOn() {
    longPressed = true;
  }

  void longPressedOff() {
    longPressed = false;
    cardSelectList = List.generate(items.length, (index) => false);
    selectedItems = [];
    notifyListeners();
  }

  void themeContainerChange() {
    isthemeContainer = !isthemeContainer;
    notifyListeners();
  }

  void themeContainerOff() {
    isthemeContainer = false;
    notifyListeners();
  }

  Future<void> changeSwitch() async {
    isSwitch = !isSwitch;
    await appInfoCache.addItem({'isSwitch': isSwitch});
    notifyListeners();
  }

  void getSwitchState() {
    try {
      final userAppInfo = appInfoCache.getItem('');
      final switchState = userAppInfo?.entries.singleWhere(
        (element) => element.key == 'isSwitch',
      );
      isSwitch = switchState?.value;
    } catch (e) {
      isSwitch = true;
    }
    notifyListeners();
  }

  void allcardsClosed() {
    cardOpenList = List.generate(items.length, (index) => false);
  }

  Future<void> getNoteProperties(BuildContext context) async {
    try {
      final userAppInfo = appInfoCache.getItem('');
      final noteProperties = userAppInfo?.entries.singleWhere(
        (element) => element.key == 'noteAreaProperties',
      );
      final properties = noteProperties?.value;
      isTicket = properties.entries.first.value;
      if (isTicket) {
        currentBackColor = properties.entries
            .singleWhere((element) => element.key == 'backgroundColor')
            .value;
        color = properties.entries
            .singleWhere((element) => element.key == 'color')
            .value;
        fontSize = properties.entries
            .singleWhere((element) => element.key == 'fontSize')
            .value;
        fontFamily = properties.entries
            .singleWhere((element) => element.key == 'fontFamily')
            .value;
        isTextAlignCenter = properties.entries
            .singleWhere((element) => element.key == 'isTextAlignCenter')
            .value;
        currentCanvas = properties.entries
            .singleWhere((element) => element.key == 'canvas')
            .value
            .toString()
            .convertToImgItems;
        currentBlendMode = properties.entries
            .singleWhere((element) => element.key == 'blendMode')
            .value
            .toString()
            .convertToBlendMode;
        fontHeight = properties.entries
            .singleWhere((element) => element.key == 'fontHeight')
            .value;
        blendOpacity = properties.entries
            .singleWhere((element) => element.key == 'opacity')
            .value;
      } else {
        isTicket = false;
        currentBackColor = '#dfe6e0';
        currentCanvas = ImgItems.TRANS;
        currentBlendMode = BlendMode.multiply;
        color = '#2f4f4f';
        fontFamily = FontFamilyConstant.gotham;
        fontSize = 0.04;
        fontHeight = 1.5;
        isTextAlignCenter = false;
        blendOpacity = 1.0;
      }
    } catch (e) {}
    notifyListeners();
  }
}
