import "dart:typed_data";
import "dart:ui" as ui show Image, ImageByteFormat;

import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";
import "../../ux_improvements.dart";

class ScreenshotImage {
  final int width;
  final int height;
  final ByteData data;

  Size get size => Size(width.toDouble(), height.toDouble());

  double get aspectRatio => width / height;

  const ScreenshotImage({
    required this.width,
    required this.height,
    required this.data,
  });
}

class ScreenshotBoundaryController {
  final GlobalKey key;

  ScreenshotBoundaryController() : key = GlobalKey();

  /// takes a [ScreenshotImage] of the widgets inside the ancestor [ScreenshotBoundary]
  ///
  /// increase [pixelRatio] if your image looks pixelated
  Future<ScreenshotImage> takeScreenshot({
    double pixelRatio = 1,
    ui.ImageByteFormat format = ui.ImageByteFormat.png,
  }) async {
    RenderObject? o = key.currentContext?.findRenderObject();

    if (o is! RenderRepaintBoundary) throw const ScreenshotBoundaryNoAncestorException();

    ui.Image image = o.toImageSync(pixelRatio: pixelRatio);

    ByteData? data = await image.toByteData(format: format);

    if (data == null) throw const ScreenshotBoundaryNoImageException();

    return ScreenshotImage(
      width: image.width,
      height: image.height,
      data: data,
    );
  }
}
