/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/init/cache/favorite_note_cache.dart';
import '../../../core/init/cache/home_note_cache.dart';
import '../../../core/init/cache/map_cache.dart';
import '../../../product/extension/string_extension.dart';
import '../../../product/lang/locale_keys.g.dart';
import '../../../core/init/cache/history_note_cache.dart';
import '../../../core/init/cache/abstract_manager.dart';
import '../../../product/constant/hive_constant.dart';
import '../../../product/enums/views_name_enum.dart';
import '../../../product/model/note_model.dart';

class HomeViewProvider extends ChangeNotifier {
  HomeViewProvider() {
    init();
  }
  late final IGeneralCacheManager<NoteModel> homeCache;
  late final IGeneralCacheManager<NoteModel> favoriteCache;
  late final IGeneralCacheManager<NoteModel> historyCache;
  late final IGeneralCacheManager<Map> favoriteIdAndItemIdCache;
  late final CollectionReference ref;
  List<NoteModel> items = [];
  late var firebaseItemsJson;
  late List<bool> cardOpenList;
  late List<bool> cardSelectList;
  late List<NoteModel> searchHistoryItems;
  List<String> deletingKeys = [];
  List<String> deletingHistoryKeys = [];
  Map<String, List<String>> deletingItems = {};
  Map<dynamic, dynamic> favoriteIdAndItemId = {};
  bool longPressed = false;
  bool openCardIconVisibility = false;
  bool isthemeContainer = false;
  TextEditingController searchController = TextEditingController();
  bool isAddViewOpen = false;
  bool isSwitch = true;

  bool isTicket = false;
  String currentBackColor = '#fef5ee';
  String color = '#0c0c0c';
  double fontSize = 21.0;
  bool isTextAlignCenter = false;

  Future<void> init() async {
    homeCache = HomeNoteCache(itemBoxkey: HiveConstant.itemsBoxKey);
    favoriteCache =
        FavoriteNoteCache(itemBoxkey: HiveConstant.favoriteItemsBoxKey);
    historyCache =
        HistoryNoteCache(itemBoxkey: HiveConstant.historyItemsBoxKey);
    favoriteIdAndItemIdCache =
        MapItemCache(itemBoxkey: HiveConstant.mapItemsBoxKey);
    await favoriteCache.init();
    await historyCache.init();
    await favoriteIdAndItemIdCache.init();
    await homeCache.init();
    getFirebaseDatas();
    updateAppInfoCache();
  }

  Future<void> getFirebaseDatas() async {
    /*await homeCache.boxClear();
    await historyCache.boxClear();
    await favoriteCache.boxClear();
    await favoriteIdAndItemIdCache.boxClear();*/
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.vpn) {
        ref = FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('notes');
        firebaseItemsJson =
            (await ref.orderBy('date', descending: true).get()).docs;

        firebaseItemsJson = firebaseItemsJson
            .map(
              (e) => NoteModel.fromJson(e.data()),
            )
            .toList();
      } else {
        firebaseItemsJson = null;
      }
      //delete işlemi için docs[0].reference
      //yani yukarıdaki e.reference olmuş oluyor.
      //(await ref.orderBy('date', descending: true).get()).docs.first.reference.delete();
    } catch (e) {
      firebaseItemsJson = null;
    }
    itemsListGenerate(ViewsName.HOME);
  }

  Future<void> updateAppInfoCache() async {
    favoriteIdAndItemId = favoriteIdAndItemIdCache.getItem('') ?? {};
    getSwitchState();
    notifyListeners();
  }

  Future<List<NoteModel>> itemsListGenerate(Enum whereComeFrom) async {
    switch (whereComeFrom) {
      case ViewsName.HOME:
        await listGenerate(homeCache);
        searchController.text = '';
        cardOpenList = List.generate(items.length, (index) => false);
        cardSelectList = List.generate(items.length, (index) => false);
        return items;
      case ViewsName.FAVORITE:
        await listGenerate(favoriteCache);
        //items = favoriteCache.getAllItems();
        cardOpenList = List.generate(items.length, (index) => false);
        cardSelectList = List.generate(items.length, (index) => false);
        return items;
      case ViewsName.HISTORY:
        await listGenerate(historyCache);
        //items = historyCache.getAllItems();
        cardOpenList = List.generate(items.length, (index) => false);
        cardSelectList = List.generate(items.length, (index) => false);
        return items;
    }
    return items;
  }

  Future<void> listGenerate(IGeneralCacheManager<NoteModel> cache) async {
    if (firebaseItemsJson != null) {
      if (cache.itemBoxkey == HiveConstant.favoriteItemsBoxKey) {
        items = firebaseItemsJson; // favotie true olanları
      } else if (cache.itemBoxkey == HiveConstant.historyItemsBoxKey) {
        items = firebaseItemsJson; // history true olanları
      } else {
        List<dynamic> list =
            firebaseItemsJson.where((e) => e.isHistory == false).toList();
        items = list.cast<NoteModel>();
        firebaseItemsJson = null;
      }
    } else {
      items = cache.getAllItems();
      searchHistoryItems = historyCache.getAllItems();
    }
    notifyListeners();
  }

  Future<void> totalValuesInItems(String value) async {
    if (searchController.text == '') {
      items = await itemsListGenerate(ViewsName.HOME);
    } else {
      items = searchList(value);
    }
    notifyListeners();
  }

  List<NoteModel> searchList(String value) {
    final findInMainItems = items.where((e) {
      String contentAndTitle =
          '${e.content ?? ''}${(e.title) == '' ? LocaleKeys.nameless.locale : e.title}';
      return contentAndTitle.removeSpecialCharacter
          .contains(value.removeSpecialCharacter);
    }).toList();
    final findInHistoryItems = searchHistoryItems.where((e) {
      String contentAndTitle =
          '${e.content ?? ''}${(e.title) == '' ? 'LocaleKeys.nameless.locale' : e.title}';
      return contentAndTitle.toLowerCase().contains(value.toLowerCase());
    }).toList();
    findInMainItems.addAll(findInHistoryItems);
    cardOpenList = List.generate(findInMainItems.length, (index) => false);
    cardSelectList = List.generate(findInMainItems.length, (index) => false);
    return findInMainItems;
  }

  Future<void> favoriteItemCardState(
    NoteModel item,
    bool isComeFromFavorite,
    bool isComeFromSearch,
  ) async {
    MapEntry<dynamic, dynamic> deletingId = const MapEntry('', '');
    NoteModel noteItem;
    if (item.isFavorite == true || isComeFromFavorite || isComeFromSearch) {
      if (isComeFromFavorite) {
        deletingId = favoriteIdAndItemId.entries.singleWhere(
          (element) => element.key == item.id,
        );
        noteItem = homeCache
            .getAllItems()
            .singleWhere((element) => element.id == deletingId.value);
        noteItem.isFavorite = false;
        await homeCache.addItem(noteItem);
      } else if (isComeFromSearch) {
        if (item.isFavorite == true) {
          deletingId = favoriteIdAndItemId.entries.singleWhere(
            (element) => element.value == item.id,
          );
          item.isFavorite = false;
          await homeCache.addItem(item);
          notifyListeners();
        } else {
          String id = DateTime.now().microsecondsSinceEpoch.toString();
          await favoriteCache.addItem(
            NoteModel(
              date: item.date,
              id: id,
              title: item.title,
              content: item.content,
              isFavorite: true,
              isHistory: false,
              isTextCenter: item.isTextCenter,
              backgroundColor: item.backgroundColor,
              color: item.color,
              fontSize: item.fontSize,
            ),
          );
          final findItem =
              items.singleWhere((element) => element.id == item.id);
          findItem.isFavorite = true;
          await homeCache.addItem(findItem);
          await favoriteIdAndItemIdCache.addItem({id: item.id});
          favoriteIdAndItemId = favoriteIdAndItemIdCache.getItem('') ?? {};
        }
      } else {
        deletingId = favoriteIdAndItemId.entries.singleWhere(
          (element) => element.value == item.id,
        );
        item.isFavorite = false;
        await homeCache.addItem(item);
      }

      await favoriteCache.deleteItems([deletingId.key]);
      await favoriteIdAndItemIdCache.deleteItem(deletingId.key);
    } else {
      String id = DateTime.now().microsecondsSinceEpoch.toString();
      await favoriteCache.addItem(
        NoteModel(
          date: item.date,
          id: id,
          title: item.title,
          content: item.content,
          isFavorite: true,
          isHistory: false,
          isTextCenter: item.isTextCenter,
          backgroundColor: item.backgroundColor,
          color: item.color,
          fontSize: item.fontSize,
        ),
      );
      item.isFavorite = true;
      await homeCache.addItem(item);
      await favoriteIdAndItemIdCache.addItem({id: item.id});
      favoriteIdAndItemId = favoriteIdAndItemIdCache.getItem('') ?? {};
    }

    if (isComeFromFavorite) {
      items = favoriteCache.getAllItems();
    } else {
      items = homeCache.getAllItems();
      totalValuesInItems(searchController.text);
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

  void longPressState(bool comeFromHistory, NoteModel item, int index) {
    if (!longPressed) {
      longPressedOn();

      selectedItemState(comeFromHistory, item, index);

      final favItem = favoriteIdAndItemId.entries.singleWhere(
        (element) => element.value == items[index].id,
        orElse: () => const MapEntry('NoN', 'NoN'),
      );
      deletingItems.addAll({
        items[index].id: [items[index].id, favItem.key]
      });
    }
  }

  void onTapState(bool comeFromHistory, NoteModel item, int index) {
    if (longPressed) {
      selectedItemState(comeFromHistory, item, index);
      if (cardSelectList[index]) {
        final favItems = favoriteIdAndItemId.entries.singleWhere(
          (element) => element.value == items[index].id,
          orElse: () => const MapEntry('NoN', 'NoN'),
        );
        deletingItems.addAll({
          items[index].id: [items[index].id, favItems.key]
        });
      }
    }

    final containsTrue =
        cardSelectList.where((element) => element == true).toList();

    if (containsTrue.isEmpty) {
      longPressedOff();
    }
  }

  Future<void> deleteSelectedItems({required bool comeFromHistory}) async {
    if (!comeFromHistory) {
      deletingItems.forEach((key, value) => deletingKeys.addAll(value));
      addHistoryItems();
      await homeCache.deleteItems(deletingKeys);
      await favoriteCache.deleteItems(deletingKeys);
      itemsListGenerate(ViewsName.HOME);
      longPressedOff();
    } else {
      deletingItems.forEach((key, value) => deletingHistoryKeys.addAll(value));
      await historyCache.deleteItems(deletingHistoryKeys);
      itemsListGenerate(ViewsName.HISTORY);
      longPressedOff();
    }
  }

  Future<void> selectedItemState(
      bool comeFromHistory, NoteModel item, int index) async {
    if (cardSelectList[index]) {
      cardSelectList[index] = false;
      deletingItems.removeWhere((key, value) => key == items[index].id);
    } else {
      cardSelectList[index] = true;
    }
    notifyListeners();
  }

  Future<void> addHistoryItems() async {
    List<NoteModel> comedItems = homeCache.getSpesificItems(deletingKeys);
    List<NoteModel> newHistoryItems = [];

    /*final comedFirestoreItems =
        (await ref.where('id', whereIn: deletingKeys).get()).docs;

    for (var element in comedFirestoreItems) {
      
      element.reference.set();
    }*/

    for (NoteModel element in comedItems) {
      newHistoryItems.add(NoteModel(
        date: element.date,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: element.title,
        content: element.content,
        isFavorite: false,
        isHistory: true,
        isTextCenter: element.isTextCenter,
        backgroundColor: element.backgroundColor,
        color: element.color,
        fontSize: element.fontSize,
      ));
    }
    await historyCache.addListItems(newHistoryItems);
  }

  Future<void> restoreItems(NoteModel item, bool isComeFromHistory) async {
    await homeCache.addItem(
      NoteModel(
        date: item.date,
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: item.title,
        content: item.content,
        isFavorite: false,
        isHistory: false,
        isTextCenter: item.isTextCenter,
        backgroundColor: item.backgroundColor,
        color: item.color,
        fontSize: item.fontSize,
      ),
    );
    await historyCache.deleteItems([item.id]);
    searchHistoryItems = historyCache.getAllItems();
    if (!isComeFromHistory) {
      itemsListGenerate(ViewsName.HOME);
      totalValuesInItems(searchController.text);
    } else {
      itemsListGenerate(ViewsName.HISTORY);
    }
    notifyListeners();
  }

  Future<void> cleaningQuery() async {
    if (deletingItems.isEmpty) {
      await historyCache.boxClear();
      //await updateAppInfoCache();
    } else {
      deleteSelectedItems(comeFromHistory: true);
    }
    itemsListGenerate(ViewsName.HISTORY);
    notifyListeners();
  }

  void longPressedOn() {
    longPressed = true;
    deletingItems = {};
  }

  void longPressedOff() {
    longPressed = false;
    cardSelectList = List.generate(items.length, (index) => false);
    deletingItems = {};
    deletingKeys = [];
    deletingHistoryKeys = [];
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

  void addViewChange() {
    isAddViewOpen = true;
    notifyListeners();
  }

  void addViewTrue() {
    isAddViewOpen = false;
    notifyListeners();
  }

  Future<void> changeSwitch() async {
    isSwitch = !isSwitch;
    await favoriteIdAndItemIdCache.addItem({'isSwitch': isSwitch});
    notifyListeners();
  }

  void getSwitchState() {
    try {
      final userAppInfo = favoriteIdAndItemIdCache.getItem('');
      final switchState = userAppInfo?.entries.singleWhere(
        (element) => element.key == 'isSwitch',
      );
      isSwitch = switchState?.value;
    } catch (e) {
      isSwitch = true;
    }
  }

  void getNoteProperties(BuildContext context) {
    try {
      final userAppInfo = favoriteIdAndItemIdCache.getItem('');
      final noteProperties = userAppInfo?.entries.singleWhere(
        (element) => element.key == 'noteProperties',
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
        isTextAlignCenter = properties.entries
            .singleWhere((element) => element.key == 'isTextAlignCenter')
            .value;
      } else {
        isTicket = false;
        currentBackColor = '#fef5ee';
        color = '#0c0c0c';
        isTextAlignCenter = false;
        fontSize = 21.0;
        notifyListeners();
      }
    } catch (e) {
      isTicket = false;
      currentBackColor = '#fef5ee';
      color = '#0c0c0c';
      isTextAlignCenter = false;
      fontSize = 21.0;
    }
  }

  NoteModel? getMateGivenItem(NoteModel item, {required bool isComeFavorite}) {
    final homeAndFavItemsIds = favoriteIdAndItemIdCache.getItem('');
    MapEntry<dynamic, dynamic>? findedItemIds;
    try {
      findedItemIds = homeAndFavItemsIds?.entries.singleWhere(
        (element) => element.value == item.id || element.key == item.id,
      );
    } catch (e) {
      return null;
    }
    if (isComeFavorite) {
      NoteModel findHomeItem = homeCache
          .getAllItems()
          .singleWhere((element) => element.id == findedItemIds?.value);
      return findHomeItem;
    } else {
      try {
        NoteModel findFavItem = favoriteCache
            .getAllItems()
            .singleWhere((element) => element.id == findedItemIds?.key);
        return findFavItem;
      } catch (e) {
        return null;
      }
    }
  }
}


//!FIREBASE 
   final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.vpn) {
      await (await ref.where('id', isEqualTo: item.id).get())
          .docs
          .first
          .reference
          .update(item.toJson());
    }


          /*final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.vpn) {
        final deger = (await ref.where('id', isEqualTo: element.id).get()).docs;
        final deger2 = deger.first;
        final deger3 = deger2.reference;

        deger3.update(element.toJson());
      }*/

      
    /*final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.vpn) {
      await (await ref.where('id', isEqualTo: item.id).get())
          .docs
          .first
          .reference
          .update(item.toJson());
    }*/
*/