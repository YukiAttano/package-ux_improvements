import "package:flutter/material.dart";
import "unbound_stack/unbound_stack.dart";

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

  /// This option does not clip [overlays]
  ///
  /// falls back to [Clip.none]
  ///
  /// [overlays] are laid out and than transformed according to their configuration.
  /// As clipping is applied on the layout bounds and not on the transformed bounds,
  /// clipping has no direct visual effect in most cases.
  final Clip clipBehavior;
  final StackFit fit;
  final TextDirection? textDirection;

  /// if true (the default), [overlays] are hittable and receive pointer feedback outside of [child] bounds.
  ///
  /// this is true by default, as a performance impact is not expected.
  final bool ignoreBounds;

  SuperimposeBox({
    super.key,
    this.overlays = const [],
    EdgeInsets? overlayPadding,
    required this.child,
    Clip? clipBehavior,
    StackFit? fit,
    this.textDirection,
    bool? ignoreBounds,
  })  : overlayPadding =
            overlayPadding ?? const EdgeInsets.symmetric(horizontal: 12),
        clipBehavior = clipBehavior ?? Clip.none,
        fit = fit ?? StackFit.loose,
        ignoreBounds = ignoreBounds ?? true,
        _link = LayerLink();

  SuperimposeBox.single({
    Key? key,
    Alignment? overlayAlign,
    Alignment? childAlign,
    Widget? overlay,
    EdgeInsets? overlayPadding,
    Clip? clipBehavior,
    StackFit? fit,
    TextDirection? textDirection,
    bool? ignoreBounds,
    required Widget child,
  }) : this(
          key: key,
          overlays: [
            Superimpose(
                childAlign: childAlign,
                overlayAlign: overlayAlign,
                overlay: overlay)
          ],
          overlayPadding: overlayPadding,
          clipBehavior: clipBehavior,
          fit: fit,
          textDirection: textDirection,
          ignoreBounds: ignoreBounds,
          child: child,
        );

  final LayerLink _link;

  @override
  Widget build(BuildContext context) {
    return UnboundStack(
      hitTestIgnoreBound: ignoreBounds,
      clipBehavior: clipBehavior,
      fit: fit,
      textDirection: textDirection,
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
