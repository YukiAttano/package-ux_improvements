import 'package:flutter/material.dart';
import 'shimmer.dart';

class ShimmerBox extends StatefulWidget {
  final Widget child;

  const ShimmerBox({super.key, required this.child});

  @override
  State<ShimmerBox> createState() => _ShimmerBoxState();
}

class _ShimmerBoxState extends State<ShimmerBox> {

  Listenable? _shimmerChanges;

  @override
  Widget build(BuildContext context) {
    ShimmerState shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      // The ancestor Shimmer widget isn’t laid
      // out yet. Return an empty box.
      return const SizedBox();
    }
    Size shimmerSize = shimmer.size;
    Gradient gradient = shimmer.gradient;
    Offset offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject()! as RenderBox,
    );

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
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
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

