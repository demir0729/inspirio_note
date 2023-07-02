import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:my_notes/product/constant/id_and_key_constant.dart';

part 'note_model.g.dart';

@HiveType(typeId: IdAndKeyConstant.noteTypeId)
class NoteModel {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? content;
  @HiveField(2)
  late String id;
  @HiveField(3)
  late bool isFavorite;
  @HiveField(4)
  late String date;
  @HiveField(5)
  late bool isHistory;
  @HiveField(6)
  late bool isTextCenter;
  @HiveField(7)
  late String backgroundColor;
  @HiveField(8)
  late String color;
  @HiveField(9)
  late double fontSize;
  @HiveField(10)
  late String timestamp;
  @HiveField(11)
  late String fontFamily;
  @HiveField(12)
  late String canvas;
  @HiveField(13)
  late String blendMode;
  @HiveField(14)
  late double fontHeight;
  @HiveField(15)
  late double opacity;
  NoteModel({
    this.title,
    this.content,
    required this.id,
    required this.isFavorite,
    required this.date,
    required this.isHistory,
    required this.isTextCenter,
    required this.backgroundColor,
    required this.color,
    required this.fontSize,
    required this.fontFamily,
    required this.timestamp,
    required this.canvas,
    required this.blendMode,
    required this.fontHeight,
    required this.opacity,
  });

  NoteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    date = json['date'];
    backgroundColor = json['backgroundColor'];
    color = json['color'];
    isTextCenter = json['isTextCenter'];
    fontSize = json['fontSize'];
    isFavorite = json['isFavorite'];
    isHistory = json['isHistory'];
    timestamp = json['timestamp'];
    fontFamily = json['fontFamily'];
    canvas = json['canvas'];
    blendMode = json['blendMode'];
    fontHeight = json['fontHeight'];
    opacity = json['opacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> notes = {};
    notes['id'] = id;
    notes['title'] = title;
    notes['content'] = content;
    notes['date'] = date;
    notes['isFavorite'] = isFavorite;
    notes['isHistory'] = isHistory;
    notes['isTextCenter'] = isTextCenter;
    notes['backgroundColor'] = backgroundColor;
    notes['color'] = color;
    notes['fontSize'] = fontSize;
    notes['timestamp'] = timestamp;
    notes['fontFamily'] = fontFamily;
    notes['canvas'] = canvas;
    notes['blendMode'] = blendMode;
    notes['fontHeight'] = fontHeight;
    notes['opacity'] = opacity;
    return notes;
  }

  @override
  bool operator ==(covariant NoteModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.content == content && other.id == id;
  }

  @override
  int get hashCode => title.hashCode ^ content.hashCode ^ id.hashCode;
}
