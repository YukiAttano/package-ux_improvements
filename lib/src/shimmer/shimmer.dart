import "package:flutter/material.dart";

import "shimmer_area.dart";

/// A synchronized shimmer child on the screen.
/// Needs a [ShimmerArea] as an ancestor to be placed in the tree
class Shimmer
    extends StatefulWidget {
  // colorBurn, softLight and darken look ultra sexy with a ColoredBox and color around 0.4 opacity.
  // But changing the used ShimmerArea gradient would allow the same effect without using a ColoredBox.
  /// If you experience the Shader to be applied to the background and not just to the widgets in the foreground,
  /// change the [blendMode], the Gradient or use dummy widgets and apply the [Shimmer] directly to them.
  final BlendMode
      blendMode;
  final Widget
      child;

  /// use [BlendMode.dst] to cancel the effect
  const Shimmer(
      {super.key,
      this.blendMode =
          BlendMode
              .srcATop,
      required this.child});

  @override
  State<Shimmer>
      createState() =>
          _ShimmerState();
}

class _ShimmerState
    extends State<
        Shimmer> {
  Listenable?
      _shimmerChanges;

  @override
  void initState() {
    super
        .initState();

    _initListener();

    ShimmerArea.of(
            context)
        ?.shimmerChanges
        .addListener(
            _initListener);
  }

  void
      _initListener() {
    if (_shimmerChanges !=
        null) {
      _shimmerChanges!
          .removeListener(
              _onShimmerChange);
    }
    _shimmerChanges =
        ShimmerArea.of(
                context)
            ?.shimmerChanges
            .value;
    if (_shimmerChanges !=
        null) {
      _shimmerChanges!
          .addListener(
              _onShimmerChange);
    }
  }

  @override
  Widget build(
      BuildContext
          context) {
    ShimmerAreaState
        shimmer =
        ShimmerArea.of(
            context)!;
    if (!shimmer
        .isSized) {
      // The ancestor Shimmer widget isn’t laid
      // out yet. Return an empty box.
      return const SizedBox
          .shrink();
    }
    Size
        shimmerSize =
        shimmer
            .size;
    Gradient
        gradient =
        shimmer
            .gradient;

    RenderBox?
        shimmerBox =
        context.findRenderObject()
            as RenderBox?;

    Offset
        offsetWithinShimmer =
        shimmerBox !=
                null
            ? shimmer.getDescendantOffset(
                descendant:
                    shimmerBox)
            : Offset
                .zero;

    return ShaderMask(
      blendMode: widget
          .blendMode,
      shaderCallback:
          (bounds) {
        return gradient
            .createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer
                .dx,
            -offsetWithinShimmer
                .dy,
            shimmerSize
                .width,
            shimmerSize
                .height,
          ),
        );
      },
      child: widget
          .child,
    );
  }

  @override
  void dispose() {
    _shimmerChanges
        ?.removeListener(
            _onShimmerChange);
    super.dispose();
  }

  void
      _onShimmerChange() {
    setState(() {
      // update the shimmer painting.
    });
  }
}
