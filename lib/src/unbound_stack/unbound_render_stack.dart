import "package:flutter/rendering.dart";

/// same as [RenderStack] but allows to hit widgets outside of its own bounds
class UnboundRenderStack extends RenderStack {
  bool hitTestIgnoreBound;

  UnboundRenderStack({
    super.children,
    super.alignment,
    super.textDirection,
    super.fit,
    super.clipBehavior,
    required this.hitTestIgnoreBound,
  });

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (hitTestIgnoreBound) {
      if (hitTestChildren(result, position: position) || hitTestSelf(position)) {
        result.add(BoxHitTestEntry(this, position));
        return true;
      }
    } else {
      super.hitTest(result, position: position);
    }

    return false;
  }
}
