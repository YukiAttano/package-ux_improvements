import 'package:flutter/material.dart';
import 'shimmer_area.dart';

/// A synchronized shimmer child on the screen.
/// Needs a [ShimmerArea] to be placed in the tree
class Shimmer extends StatefulWidget {
  final Widget child;

  const Shimmer({super.key, required this.child});

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> {

  Listenable? _shimmerChanges;

  @override
  Widget build(BuildContext context) {
    ShimmerAreaState shimmer = ShimmerArea.of(context)!;
    if (!shimmer.isSized) {
      // The ancestor Shimmer widget isn’t laid
      // out yet. Return an empty box.
      return const SizedBox();
    }
    Size shimmerSize = shimmer.size;
    Gradient gradient = shimmer.gradient;

    RenderBox? shimmerBox = context.findRenderObject() as RenderBox?;

    Offset offsetWithinShimmer = shimmerBox != null ? shimmer.getDescendantOffset(descendant: shimmerBox) : Offset.zero;

    return ShaderMask(
      blendMode: BlendMode.srcATop,
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = ShimmerArea
        .of(context)
        ?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    setState(() {
      // update the shimmer painting.
    });
  }

}

