import "package:flutter/material.dart";

import "glass.dart";
import "styles/glass_container_style.dart";

class GlassContainer extends StatelessWidget {
  final GlassContainerStyle? style;
  final BackdropKey? groupKey;
  final bool? enabled;
  final Widget child;

  const GlassContainer({super.key, this.style, this.groupKey, this.enabled, required this.child});

  @override
  Widget build(BuildContext context) {
    GlassContainerStyle s = GlassContainerStyle.of(context, style);

    return Glass(
      groupKey: groupKey,
      enabled: enabled,
      sigmaY: s.sigmaY,
      sigmaX: s.sigmaX,
      blendMode: s.blendMode,
      borderRadius: s.borderRadius,
      clipBehavior: s.clipBehavior,
      child: ColoredBox(
        color: s.color!.withValues(alpha: s.opacity),
        child: _DecoratedChild(style: s, child: child),
      ),
    );
  }
}

class _DecoratedChild extends StatelessWidget {
  final GlassContainerStyle style;
  final Widget child;

  const _DecoratedChild({required this.style, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: style.border,
        borderRadius: style.borderRadius,
        gradient: style.gradient,
        shape: style.shape ?? BoxShape.rectangle,
        color: style.color?.withValues(alpha: style.opacity),
        boxShadow: [
          BoxShadow(
            color: style.tint!.withValues(alpha: style.tintOpacity),
            blurRadius: style.tintBlurRadius!,
          ),
        ],
      ),
      child: child,
    );
  }
}
