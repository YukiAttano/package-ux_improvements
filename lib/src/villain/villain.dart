/// @docImport 'package:flutter/material.dart';
library;

import "dart:math" as math show max, min;

import "package:flutter/rendering.dart";
import "package:flutter/widgets.dart";

/// will take the same space as [child] without lay-outing it (preventing Heroes from functioning).
///
/// This is useful for screens and pages that have a [FloatingActionButton] or another [Hero] widget
/// hovering above them and requiring the list to scroll high enough
/// to display all items while also avoiding hero collisions.
///
/// The most easy way would be to inject the same widget into the list,
/// wrapped in a [Visibility.maintain] and [IgnorePointer] but this could cause [Hero] collisions.
///
/// The [Villain] widget will not lay-out the [child] and thus prevents heroes from functioning
/// while taking up the same space just like a [Visibility.maintain] would do
///
/// Example
/// ```dart
/// ListView(
///   children: [
///     ListTile(),
///     ListTile(),
///     Villain(
///       child: Scaffold.maybeOf(context)?.widget.floatingActionButton,
///     ),
///   ],
/// ),
/// ```
class Villain extends SingleChildRenderObjectWidget {
  const Villain({super.key, super.child});

  @override
  RenderUnlaidBox createRenderObject(BuildContext context) {
    return RenderUnlaidBox();
  }
}

class RenderUnlaidBox extends RenderProxyBox {
  RenderUnlaidBox();

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child != null) {
      Size childSize = child!.getDryLayout(const BoxConstraints());
      return Size(
        math.max(constraints.minWidth, math.min(constraints.maxWidth, childSize.width)),
        math.max(constraints.minHeight, math.min(constraints.maxHeight, childSize.height)),
      );
    } else {
      return computeSizeForNoChild(constraints);
    }
  }

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }
}
