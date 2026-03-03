import "dart:ui";

import "package:flutter/material.dart";
import "styles/glass_container_style.dart";

class GlassContainer extends StatelessWidget {
  final GlassContainerStyle? style;
  final BackdropKey? groupKey;
  final bool? enabled;
  final Widget child;

  const GlassContainer({super.key, this.style, this.groupKey, this.enabled, required this.child});

  @override
  Widget build(BuildContext context) {
    GlassContainerStyle? s = GlassContainerStyle.of(context, style);

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: s.borderRadius ?? BorderRadius.zero,
            clipBehavior: s.clipBehavior!,
            child: _Filter(
              groupKey: groupKey,
              enabled: enabled,
              sigmaY: s.sigmaY,
              sigmaX: s.sigmaX,
              child: ColoredBox(
                color: s.color!.withValues(alpha: s.opacity),
              ),
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: s.border,
            borderRadius: s.borderRadius,
            gradient: s.gradient,
            shape: s.shape ?? BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: s.tint!.withValues(alpha: s.tintOpacity),
                blurRadius: s.tintBlurRadius!,
              ),
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}

class _Filter extends StatelessWidget {
  final BackdropKey? groupKey;
  final bool enabled;
  final BlendMode blendMode;
  final double sigmaX;
  final double sigmaY;
  final Widget? child;

  const _Filter({
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
