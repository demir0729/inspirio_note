import 'dart:io';
import 'dart:ui' as ui;

import 'package:bitmap/bitmap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image/image.dart' as imglib;
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_image_renderer/pdf_image_renderer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../product/constant/duration_constant.dart';
import '../../product/extension/string_extension.dart';
import '../../product/lang/locale_keys.g.dart';
import '../../product/model/note_model.dart';
import '../widgets/flushbar_widget.dart';

class PdfAndJpgManager extends ChangeNotifier {
  ValueNotifier<bool> isPdfLoading = ValueNotifier(false);
  ValueNotifier<bool> isJpgLoading = ValueNotifier(false);
  ValueNotifier<bool> isJpgIconLoading = ValueNotifier(false);

  void changeLoading(ValueNotifier<bool> loading) {
    loading.value = !loading.value;
  }

  Future<void> changeJpgIconLoading() async {
    isJpgIconLoading.value = !isJpgIconLoading.value;
    await Future.delayed(const Duration(seconds: 6));
    isJpgIconLoading.value = !isJpgIconLoading.value;
  }

  Future<void> createPdf(NoteModel item, BuildContext context,
      {required bool isConvertJpg, required double quality}) async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
      final currentStatus = await Permission.storage.status;
      if (!currentStatus.isGranted) {
        return;
      }
    }

    if (isConvertJpg) {
      changeLoading(isJpgLoading);
    } else {
      changeLoading(isPdfLoading);
    }
    double multiple = 0;
    switch (item.fontHeight.toString()) {
      case '1.5':
        multiple = 0;
        break;
      case '1.65':
        multiple = 3;
        break;
      case '2.0':
        multiple = 5;
        break;
      case '2.5':
        multiple = 7;
        break;
      case '2.65':
        multiple = 10;
        break;
      case '3.0':
        multiple = 15;
        break;
    }
    final PdfDocument document = PdfDocument();

    File? file = await generateImage(
      'assets/img/${item.canvas}.jpg',
      Color(item.backgroundColor.hexColor).withOpacity(item.opacity),
      item.blendMode.convertToBlendMode,
    );

    String newImage =
        '${(Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationSupportDirectory())!.path}/myNotes/tempImage.jpg';

    File compressedImage = await FlutterNativeImage.compressImage(newImage,
        quality: 90, percentage: 90);

    final imgData = compressedImage.readAsBytesSync();

    document.pageSettings.margins.all = 0;
    document.pageSettings.size = PdfPageSize.note;

    PdfTemplate template =
        PdfTemplate(PdfPageSize.note.width, PdfPageSize.note.height);

    template.graphics!.drawImage(
      PdfBitmap(imgData),
      Rect.fromLTWH(
        0,
        0,
        PdfPageSize.note.width,
        PdfPageSize.note.height,
      ),
    );
    final PdfPage page = document.pages.add();

    final data = await rootBundle.load('assets/fonts/${item.fontFamily}');
    final dataint =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    final font = PdfTrueTypeFont(dataint, item.fontSize * 2.35);
    print((MediaQuery.of(context).size.width / 130.5));
    Color fontColor = Color(item.color.hexColor);
    String pdfTitle = (item.title ?? LocaleKeys.nameless.locale) == ''
        ? LocaleKeys.nameless.locale
        : item.title!;

    PdfTextElement(
      text: item.content ?? '',
      font: font,
      brush: PdfSolidBrush(
        PdfColor(fontColor.red, fontColor.green, fontColor.blue),
      ),
      format: PdfStringFormat(
        alignment:
            item.isTextCenter ? PdfTextAlignment.center : PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
        textDirection: PdfTextDirection.leftToRight,
        characterSpacing: 0.5,
        wordSpacing: 0.5,
        lineSpacing: item.fontHeight * multiple,
        subSuperscript: PdfSubSuperscript.superscript,
        paragraphIndent: 10,
        measureTrailingSpaces: true,
        wordWrap: PdfWordWrapType.word,
      ),
    ).draw(
      graphics: page.graphics,
      page: page,
      format: PdfLayoutFormat(
        layoutType: PdfLayoutType.paginate,
        paginateBounds: Rect.fromLTWH(
          50,
          50,
          PdfPageSize.note.width / 1.20,
          (PdfPageSize.note.height ~/ 1.134).toDouble(),
        ),
      ),
      bounds: Rect.fromLTWH(
        20,
        20,
        PdfPageSize.note.width / 1.20,
        (PdfPageSize.note.height ~/ 1.134).toDouble(),
      ),
    );
    for (var i = 0; i < document.pages.count; i++) {
      document.pages[i].graphics.drawPdfTemplate(template, const Offset(0, 0));
    }

    PdfTextElement(
      text: item.content ?? '',
      font: font,
      brush: PdfSolidBrush(
        PdfColor(fontColor.red, fontColor.green, fontColor.blue),
      ),
      format: PdfStringFormat(
        alignment:
            item.isTextCenter ? PdfTextAlignment.center : PdfTextAlignment.left,
        lineAlignment: PdfVerticalAlignment.top,
        textDirection: PdfTextDirection.leftToRight,
        characterSpacing: 0.5,
        wordSpacing: 0.5,
        lineSpacing: item.fontHeight * multiple,
        subSuperscript: PdfSubSuperscript.superscript,
        paragraphIndent: 10,
        measureTrailingSpaces: true,
        wordWrap: PdfWordWrapType.word,
      ),
    ).draw(
      graphics: page.graphics,
      page: page,
      format: PdfLayoutFormat(
        layoutType: PdfLayoutType.paginate,
        paginateBounds: Rect.fromLTWH(
          50,
          50,
          PdfPageSize.note.width / 1.20,
          (PdfPageSize.note.height ~/ 1.134).toDouble(),
        ),
      ),
      bounds: Rect.fromLTWH(
        50,
        50,
        PdfPageSize.note.width / 1.20,
        (PdfPageSize.note.height ~/ 1.134).toDouble(),
      ),
    );
    final path = (await getExternalStorageDirectory())?.path;
    await File('$path/$pdfTitle.pdf').writeAsBytes(await document.save());

    if (isConvertJpg) {
      await pdfToJpg('$path', pdfTitle, quality);
      changeLoading(isJpgLoading);
      if (context.mounted) {
        await customFlushbar(context, LocaleKeys.savedGallery.locale,
            duration: DurationConstant.duration1000());
      }
    } else {
      changeLoading(isPdfLoading);
      OpenFile.open('$path/$pdfTitle.pdf');
    }
    document.dispose();
    await file!.delete();
    await compressedImage.delete();
  }

  Future<File?> generateImage(
    String imageSource,
    Color color,
    BlendMode blendMode,
  ) async {
    File? imageResult;
    ui.Image? image;
    await _loadImageSource(imageSource).then((value) {
      image = value;
    });
    if (image != null) {
      final recorder = ui.PictureRecorder();
      var rect = Rect.fromPoints(
        const Offset(0.0, 0.0),
        Offset(
          image!.width.toDouble(),
          image!.height.toDouble(),
        ),
      );
      final canvas = Canvas(recorder, rect);
      //canvas.scale(dpr, dpr);

      Size outputSize = rect.size;
      Paint paint = Paint();

      paint.colorFilter = ColorFilter.mode(color, blendMode);

      //Image
      Size inputSize = Size(image!.width.toDouble(), image!.height.toDouble());
      final FittedSizes fittedSizes =
          applyBoxFit(BoxFit.contain, inputSize, outputSize);
      final Size sourceSize = fittedSizes.source;
      final Rect sourceRect =
          Alignment.center.inscribe(sourceSize, Offset.zero & inputSize);

      canvas.drawImageRect(image!, sourceRect, rect, paint);

      final picture = recorder.endRecording();
      final img = await picture.toImage(
          (image!.width * 1).ceil(), (image!.height * 1).ceil());

      ByteData? byteData =
          await img.toByteData(format: ui.ImageByteFormat.rawUnmodified);

      Bitmap bitmap = Bitmap.fromHeadless(
          image!.width, image!.height, byteData!.buffer.asUint8List());
      Uint8List headedIntList = bitmap.buildHeaded();

      await _writeToFile(headedIntList.buffer.asByteData()).then((value) {
        imageResult = value;
      });
      return imageResult;
    }
    return null;
  }

  Future<ui.Image> _loadImageSource(String imageSource) async {
    final imgData = (await rootBundle.load(imageSource));
    // ByteData data = _readFromFile(imageSource);
    ui.Codec codec =
        await ui.instantiateImageCodec(imgData.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  Future<File> _writeToFile(ByteData data) async {
    String path = await createFolder();
    String filePath = '$path/tempImage.jpg';
    final buffer = data.buffer;
    return File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<String> createFolder() async {
    final dir = Directory(
        '${(Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationSupportDirectory())!.path}/myNotes');
    if ((await dir.exists())) {
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }

  Future<void> pdfToJpg(
      String openFilePath, String pdfName, double quality) async {
    final doc = PdfImageRendererPdf(path: '$openFilePath/$pdfName.pdf');
    await doc.open();
    final count = await doc.getPageCount();

    imglib.Image images;

    for (int i = 0; i < count; i++) {
      await doc.openPage(pageIndex: i);
      final size = await doc.getPageSize(pageIndex: i);
      var imgPDF = await doc.renderPage(
        pageIndex: i,
        x: 0,
        y: 0,
        width: size.width,
        height: size.height,
        scale: quality,
      );
      var libImage = imglib.decodeImage(imgPDF!);
      images = libImage!;

      final imgId = DateTime.now().microsecondsSinceEpoch.toString();
      final imgFile = File('$openFilePath/$imgId$i.jpg');
      final jpg =
          await File(imgFile.path).writeAsBytes(imglib.encodeJpg(images));
      await doc.closePage(pageIndex: i);
      File compressedImage = await FlutterNativeImage.compressImage(jpg.path,
          quality: 90, percentage: 90);
      await GallerySaver.saveImage(compressedImage.path);
      await jpg.delete();
      await compressedImage.delete();
    }
    await doc.close();
  }
}
