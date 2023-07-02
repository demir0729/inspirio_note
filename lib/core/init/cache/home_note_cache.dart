import '../../../product/model/note_model.dart';
import 'abstract_manager.dart';

class HomeNoteCache extends IGeneralCacheManager<NoteModel> {
  HomeNoteCache({
    required super.itemBoxkey,
  });

  @override
  Future<void> addItem(NoteModel item) async {
    await itemBox?.put(item.id, item);
  }

  @override
  Future<void> putAllItems(Map<String, NoteModel> items) async {
    await itemBox?.putAll(items);
  }

  @override
  Future<void> deleteItem(String key) async {
    await itemBox?.delete(key);
  }

  @override
  Future<void> deleteItems(List<String> keys) async {
    await itemBox?.deleteAll(keys);
  }

  @override
  List<NoteModel> getAllItems() {
    return itemBox?.values.toList().reversed.toList() ?? [];
  }

  @override
  NoteModel? getItem(String? key) {
    return itemBox?.get(key);
  }

  @override
  List<NoteModel> getSpesificItems(List<String> keys) {
    return itemBox?.values
            .toList()
            .where((element) => keys.contains(element.id))
            .toList() ??
        [];
  }

  @override
  Future<void> addListItems(List<NoteModel> items) {
    throw UnimplementedError();
  }
}
