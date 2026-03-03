import "dart:ui";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

@internal
class GlassFilter extends StatelessWidget {
  final BackdropKey? groupKey;
  final bool enabled;
  final BlendMode blendMode;
  final double sigmaX;
  final double sigmaY;
  final Widget? child;

  const GlassFilter({
    super.key,
    this.groupKey,
    bool? enabled,
    BlendMode? blendMode,
    double? sigmaX,
    double? sigmaY,
    this.child,
  })  : enabled = enabled ?? true,
        blendMode = blendMode ?? BlendMode.srcOver,
        sigmaX = sigmaX ?? 0,
        sigmaY = sigmaY ?? 0;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      backdropGroupKey: groupKey,
      enabled: enabled,
      blendMode: blendMode,
      filter: ImageFilter.blur(
        sigmaX: sigmaX,
        sigmaY: sigmaY,
      ),
      child: child,
    );
  }
}
