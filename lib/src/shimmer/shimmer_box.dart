import "package:flutter/material.dart";
import "shimmer.dart";
import "shimmer_area.dart";

/// Creates a standalone shimmer animation for its child
class ShimmerBox extends StatelessWidget {
  final LinearGradient? gradient;
  final Duration? duration;
  final Widget child;

  const ShimmerBox({super.key, this.gradient, this.duration, required this.child});

  @override
  Widget build(BuildContext context) {
    return ShimmerArea(
      gradient: gradient,
      duration: duration,
      child: Shimmer(
        child: child,
      ),
    );
  }
}
