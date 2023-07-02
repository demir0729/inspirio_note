import 'package:my_notes/core/init/cache/abstract_manager.dart';

class MapItemCache extends IGeneralCacheManager<Map<dynamic, dynamic>> {
  MapItemCache({required super.itemBoxkey});

  @override
  Map? getItem(String? key) {
    Map<dynamic, dynamic> x = {};
    List<Map<dynamic, dynamic>> result = itemBox?.values.toList() ?? [];
    for (var element in result) {
      x[element.entries.first.key] = element.entries.first.value;
    }

    return x;
  }

  @override
  Future<void> deleteItem(String key) async {
    await itemBox?.delete(key);
  }

  @override
  Future<void> addItem(Map item) async {
   
      await itemBox?.put(item.entries.first.key, item);
   
  }

  @override
  Future<void> addListItems(List<Map> items) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteItems(List<String> keys) {
    throw UnimplementedError();
  }

  @override
  List<Map> getAllItems() {
    throw UnimplementedError();
  }

  @override
  List<Map> getSpesificItems(List<String> keys) {
    throw UnimplementedError();
  }

  @override
  Future<void> putAllItems(Map<String, Map> items) {
    throw UnimplementedError();
  }
}
