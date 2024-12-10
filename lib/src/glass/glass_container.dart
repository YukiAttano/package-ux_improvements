import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ux_improvements/src/glass/styles/glass_container_style.dart';

class GlassContainer extends StatelessWidget {
  final GlassContainerStyle? style;
  final Widget child;

  const GlassContainer({super.key, this.style, required this.child});

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
              sigmaY: s.sigmaY,
              sigmaX: s.sigmaX,
              color: s.color!.withOpacity(s.opacity!),
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: s.border,
            borderRadius: s.borderRadius,
            boxShadow: [
              BoxShadow(
                color: s.tint!.withOpacity(s.tintOpacity!),
                blurRadius: s.tintBlurRadius!,
              )
            ],
          ),
          child: child,
        ),
      ],
    );
  }
}

class _Filter extends StatelessWidget {
  final Color color;
  final double sigmaX;
  final double sigmaY;

  const _Filter({required this.color, double? sigmaX, double? sigmaY})
      : sigmaX = sigmaX ?? 0,
        sigmaY = sigmaY ?? 0;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigmaX,
        sigmaY: sigmaY,
      ),
      child: ColoredBox(
        color: color,
      ),
    );
  }
}
