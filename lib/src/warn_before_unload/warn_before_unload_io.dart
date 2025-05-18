import "package:flutter/material.dart";

class WarnBeforeUnload
    extends StatelessWidget {
  final Widget
      child;
  final bool warn;

  const WarnBeforeUnload({
    super.key,
    required this.child,
    this.warn =
        false,
  });

  @override
  Widget build(
      BuildContext
          context) {
    return child;
  }
}
