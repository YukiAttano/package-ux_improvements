import 'dart:typed_data';
import 'dart:ui' as ui show Image, ImageByteFormat;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ux_improvements/src/screenshot/screenshot_boundary_exception.dart';

class ScreenshotBoundaryController {
  final GlobalKey key;

  ScreenshotBoundaryController() : key = GlobalKey();

  Future<Uint8List> takeScreenshot({double pixelRatio = 1, ui.ImageByteFormat format = ui.ImageByteFormat.png}) async {
    RenderObject? o = key.currentContext?.findRenderObject();

    if (o is! RenderRepaintBoundary) throw const ScreenshotBoundaryNoWidgetException();

    ui.Image image = o.toImageSync(pixelRatio: pixelRatio);

    ByteData? data = await image.toByteData(format: format);

    Uint8List? bytes = data?.buffer.asUint8List();

    if (bytes == null) throw const ScreenshotBoundaryNoImageException();

    return bytes;
  }
}
