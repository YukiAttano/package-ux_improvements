//@dart=3.0

import 'dart:ui';

import 'package:flutter/widgets.dart';

/// defined after https://developer.android.com/develop/ui/compose/layouts/adaptive/window-size-classes?hl=de
enum WindowSize {
  COMPACT(0, 0),
  MEDIUM(600, 480),
  EXPANDED(840, 900);

  const WindowSize(this.width, this.height);

  final double width;
  final double height;

  static WindowSize ofWidth(double width) {
    for (var windowSize in values.reversed) {
      if (width >= windowSize.width)
      {
        return windowSize;
      }
    }

    return COMPACT;
  }

  static WindowSize ofHeight(double height) {
    for (var windowSize in values.reversed) {
      if (height >= windowSize.height)
      {
        return windowSize;
      }
    }

    return COMPACT;
  }

  static (WindowSize, WindowSize) ofSize(Size size) {
    return (ofWidth(size.width), ofHeight(size.height));
  }
}

extension WindowSizeSizeExtension on Size {
  WindowSize get widthWindowSize => WindowSize.ofWidth(width);
  WindowSize get heightWindowSize => WindowSize.ofWidth(height);
  (WindowSize, WindowSize) get windowSizes => WindowSize.ofSize(this);
}

extension DisplayWindowSizeExtension on Display {
  WindowSize get widthWindowSize => WindowSize.ofWidth(size.width);
  WindowSize get heightWindowSize => WindowSize.ofWidth(size.height);
  (WindowSize, WindowSize) get windowSizes => WindowSize.ofSize(size);
}

extension MediaQueryDataWindowSizeExtension on MediaQueryData {
  WindowSize get widthWindowSize => WindowSize.ofWidth(size.width);
  WindowSize get heightWindowSize => WindowSize.ofWidth(size.height);
  (WindowSize, WindowSize) get windowSizes => WindowSize.ofSize(size);
}

extension MediaQueryWindowSizeExtension on MediaQuery {

  /// Returns (width, height) [WindowSize] of the current view.
  ///
  /// Note: https://main-api.flutter.dev/flutter/services/SystemChrome/setPreferredOrientations.html
  /// As described in the documentation above, [MediaQuery.size] might return a letterboxed size.
  (WindowSize, WindowSize) windowSizeOf(BuildContext context) {
    return MediaQuery.sizeOf(context).windowSizes;
  }
}