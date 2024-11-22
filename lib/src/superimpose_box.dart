import "package:flutter/material.dart";
import "package:ux_improvements/src/unbound_stack/unbound_stack.dart";

class Superimpose {
  final Alignment overlayAlign;
  final Alignment childAlign;
  final Widget? overlay;

  const Superimpose({
    Alignment? overlayAlign,
    Alignment? childAlign,
    required this.overlay,
  })  : overlayAlign = overlayAlign ?? Alignment.center,
        childAlign = childAlign ?? Alignment.topCenter;
}

/// Alternative Widget to [Badge]
///
/// Allows painting [overlays] over [child] while keeping them aligned together.
class SuperimposeBox extends StatelessWidget {
  final List<Superimpose> overlays;
  final Widget child;
  final EdgeInsets overlayPadding;

  SuperimposeBox({super.key, this.overlays = const [], EdgeInsets? overlayPadding, required this.child})
      : overlayPadding = overlayPadding ?? const EdgeInsets.symmetric(horizontal: 12),
        _link = LayerLink();

  SuperimposeBox.single({
    Key? key,
    Alignment? overlayAlign,
    Alignment? childAlign,
    Widget? overlay,
    EdgeInsets? overlayPadding,
    required Widget child,
  }) : this(
          key: key,
          overlays: [Superimpose(childAlign: childAlign, overlayAlign: overlayAlign, overlay: overlay)],
          overlayPadding: overlayPadding,
          child: child,
        );

  final LayerLink _link;

  @override
  Widget build(BuildContext context) {
    return UnboundStack(
      hitTestIgnoreBound: false,
      children: [
        CompositedTransformTarget(
          link: _link,
          child: child,
        ),
        ...List.generate(
          overlays.length,
          (index) {
            Superimpose imposed = overlays[index];

            return CompositedTransformFollower(
              key: ValueKey(index),
              link: _link,
              targetAnchor: imposed.childAlign,
              followerAnchor: imposed.overlayAlign,
              child: Padding(
                padding: overlayPadding,
                child: imposed.overlay,
              ),
            );
          },
        ),
      ],
    );
  }
}
