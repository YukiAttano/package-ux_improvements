import "package:flutter/material.dart";

import "shimmer_area.dart";

/// A synchronized shimmer child on the screen.
/// Needs a [ShimmerArea] as an ancestor to be placed in the tree
class Shimmer extends StatefulWidget {
  // colorBurn, softLight and darken look ultra sexy with a ColoredBox and color around 0.4 opacity.
  // But changing the used ShimmerArea gradient would allow the same effect without using a ColoredBox.
  /// If you experience the Shader to be applied to the background and not just to the widgets in the foreground,
  /// change the [blendMode], the Gradient or use dummy widgets and apply the [Shimmer] directly to them.
  final BlendMode blendMode;
  final Widget child;

  /// use [BlendMode.dst] to cancel the effect
  const Shimmer({
    super.key,
    this.blendMode = BlendMode.srcATop,
    required this.child,
  });

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> {
  ShimmerAreaState? _area;

  @override
  void initState() {
    super.initState();

    ShimmerArea.of(context)?.addShimmerListener(_onShimmerUpdate);
  }

  void _onShimmerUpdate(Animation<double> animation) {
    setState(() {
      // update state
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _area = ShimmerArea.of(context);
  }

  @override
  Widget build(BuildContext context) {
    var area = _area;

    if (area == null || !area.isSized) {
      return widget.child;
    }
    Size shimmerSize = area.size;
    Gradient gradient = area.gradient;

    RenderBox? shimmerBox = context.findRenderObject() as RenderBox?;

    Offset offsetWithinShimmer = shimmerBox != null ? area.getDescendantOffset(descendant: shimmerBox) : Offset.zero;

    return ShaderMask(
      blendMode: widget.blendMode,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _area?.removeShimmerListener(_onShimmerUpdate);
    super.dispose();
  }
}
