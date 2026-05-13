import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareBoundaryImage(
  RenderRepaintBoundary boundary, {
  required String fileName,
  String? text,
}) async {
  final image = await boundary.toImage(pixelRatio: 3);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  final bytes = byteData?.buffer.asUint8List();
  if (bytes == null) {
    return;
  }

  final file = await _writeImage(bytes, fileName);
  await SharePlus.instance.share(
    ShareParams(
      files: [XFile(file.path)],
      text: text,
    ),
  );
}

Future<File> _writeImage(Uint8List bytes, String fileName) async {
  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}/$fileName');
  return file.writeAsBytes(bytes, flush: true);
}
