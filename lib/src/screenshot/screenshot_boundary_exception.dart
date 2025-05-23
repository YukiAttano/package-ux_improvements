abstract class ScreenshotBoundaryException implements Exception {
  final String message;

  const ScreenshotBoundaryException(this.message);
}

class ScreenshotBoundaryNoAncestorException extends ScreenshotBoundaryException {
  const ScreenshotBoundaryNoAncestorException() : super("No ScreenshotBoundary widget connected to the Controller");
}

class ScreenshotBoundaryNoImageException extends ScreenshotBoundaryException {
  const ScreenshotBoundaryNoImageException()
      : super(
          "No image could be generated. If the Screenshot Boundary wraps Widgets with animations (e.g. Splash animations) trigger this function after all animations are done",
        );
}
