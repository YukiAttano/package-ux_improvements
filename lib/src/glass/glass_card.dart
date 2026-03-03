import "package:flutter/material.dart";

import "glass_container.dart";
import "styles/glass_card_style.dart";

class GlassCard extends StatelessWidget {
  final GlassCardStyle? style;
  final BackdropKey? groupKey;
  final bool? enabled;

  final Widget child;

  const GlassCard({super.key, this.style, this.groupKey, this.enabled, required this.child});

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
        groupKey: groupKey,
        enabled: enabled,
        child: child,
      ),
    );
  }
}
