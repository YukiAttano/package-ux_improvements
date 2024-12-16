import "package:flutter/material.dart";
import "glass_container.dart";
import "styles/glass_card_style.dart";
import "styles/glass_container_style.dart";

class GlassCard extends StatelessWidget {
  final Widget child;
  final GlassCardStyle? style;

  const GlassCard({super.key, this.style, required this.child});

  @override
  Widget build(BuildContext context) {
    GlassCardStyle? s = GlassCardStyle.of(context, style);

    return Card(
      clipBehavior: s.clipBehavior,
      elevation: s.elevation,
      margin: s.margin,
      shadowColor: s.shadowColor,
      color: s.color!.withValues(alpha: s.opacity),
      shape: s.shape,
      child: GlassContainer(
        style: s.containerStyle,
        child: child,
      ),
    );
  }
}