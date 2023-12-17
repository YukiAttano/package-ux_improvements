import 'package:flutter/material.dart';
import 'shimmer.dart';
import 'shimmer_area.dart';

/// Creates a standalone shimmer animation for its child
class ShimmerBox extends StatelessWidget {
  final LinearGradient? gradient;
  final Widget child;

  const ShimmerBox({super.key, required this.child, this.gradient});

  @override
  Widget build(BuildContext context) {
    return ShimmerArea(
      gradient: gradient,
      child: Shimmer(
        child: child,
      ),
    );
  }
}
