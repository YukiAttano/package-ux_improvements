import 'package:flutter/widgets.dart';
import 'package:ux_improvements/src/screenshot/screenshot_boundary_controller.dart';

class ScreenshotBoundary extends RepaintBoundary {
  ScreenshotBoundary({ScreenshotBoundaryController? controller, super.child}) : super(key: controller?.key);
}
