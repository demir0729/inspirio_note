import 'package:hive_flutter/adapters.dart';
import '../../../product/constant/id_and_key_constant.dart';
import '../../../product/model/note_model.dart';

abstract class IGeneralCacheManager<T> {
  IGeneralCacheManager({
    required this.itemBoxkey,
  });
  String itemBoxkey;
  Box<T>? itemBox;

  Future<void> init() async {
    registerAdapter();
    if (!(itemBox?.isOpen ?? false)) {
      itemBox = await Hive.openBox(itemBoxkey);
    }
  }

  Future<void> addItem(T item);
  Future<void> putAllItems(Map<String, T> items);
  Future<void> addListItems(List<T> items);
  T? getItem(String? key);
  List<T> getAllItems();
  List<T> getSpesificItems(List<String> keys);
  Future<void> deleteItem(String key);
  Future<void> deleteItems(List<String> keys);
  void registerAdapter() {
    if (!(Hive.isAdapterRegistered(IdAndKeyConstant.noteTypeId))) {
      Hive.registerAdapter(NoteModelAdapter());
    }
  }

  Future<void> boxClear() async {
    await itemBox?.clear();
  }
  
  Future<void> boxClosed() async {
    await itemBox?.close();
  }
}
