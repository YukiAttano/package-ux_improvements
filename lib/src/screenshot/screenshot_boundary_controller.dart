import 'dart:typed_data';
import 'dart:ui' as ui show Image, ImageByteFormat;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ux_improvements/src/screenshot/screenshot_boundary_exception.dart';

class ScreenshotImage {
  final int width;
  final int height;
  final ByteData data;

  const ScreenshotImage({required this.width, required this.height, required this.data});
}


class ScreenshotBoundaryController {
  final GlobalKey key;

  ScreenshotBoundaryController() : key = GlobalKey();

  Future<ScreenshotImage> takeScreenshot({double pixelRatio = 1, ui.ImageByteFormat format = ui.ImageByteFormat.png}) async {
    RenderObject? o = key.currentContext?.findRenderObject();

    if (o is! RenderRepaintBoundary) throw const ScreenshotBoundaryNoWidgetException();

    ui.Image image = o.toImageSync(pixelRatio: pixelRatio);

    ByteData? data = await image.toByteData(format: format);

    if (data == null) throw const ScreenshotBoundaryNoImageException();

    return ScreenshotImage(width: image.width, height: image.height, data: data);
  }
}
