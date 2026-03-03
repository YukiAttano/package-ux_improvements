import "package:flutter/widgets.dart";

import "glass_filter.dart";

/// Naked glass effect
class Glass extends StatelessWidget {
  final BackdropKey? groupKey;
  final bool? enabled;
  final BlendMode? blendMode;
  final double? sigmaX;
  final double? sigmaY;
  final Clip clipBehavior;
  final BorderRadius borderRadius;

  final Widget child;

  const Glass({
    super.key,
    this.groupKey,
    this.enabled,
    this.blendMode,
    this.sigmaX,
    this.sigmaY,
    Clip? clipBehavior,
    BorderRadius? borderRadius,
    Widget? child,
  })  : clipBehavior = borderRadius == null ? Clip.none : (clipBehavior ?? Clip.antiAlias),
        borderRadius = borderRadius ?? BorderRadius.zero,
        child = child ?? const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: clipBehavior,
      child: GlassFilter(
        groupKey: groupKey,
        enabled: enabled,
        blendMode: blendMode,
        sigmaY: sigmaY,
        sigmaX: sigmaX,
        child: child,
      ),
    );
  }
}
