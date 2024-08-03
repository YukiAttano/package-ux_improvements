import 'package:flutter/widgets.dart';
import 'package:ux_improvements/src/screenshot/screenshot_boundary_controller.dart';

/// The area that is recorded
///
/// For a more advanced version check the "screenshot" package
class ScreenshotBoundary extends RepaintBoundary {
  ScreenshotBoundary({ScreenshotBoundaryController? controller, super.child}) : super(key: controller?.key);
}
