import 'package:flutter/material.dart';
import 'package:ux_improvements/src/shimmer/styles/shimmer_style.dart';

/// Controls a shimmer animation on the screen
/// Use a [Shimmer] Widget to display the effect or a [ShimmerBox] for a non-synchronized shimmer
class ShimmerArea extends StatefulWidget {
  static ShimmerAreaState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerAreaState>();
  }

  final LinearGradient gradient;
  final Widget child;

  const ShimmerArea({
    super.key,
    LinearGradient? gradient,
    Widget? child,
  })  : gradient = gradient ?? silverShimmerGradient,
        child = child ?? const SizedBox.shrink();

  ShimmerArea.fromColors({
    Key? key,
    required Color backgroundColor,
    required Color shimmerColor,
    Widget? child,
  }) : this(
          key: key,
          child: child,
          gradient: LinearGradient(
            colors: [backgroundColor, shimmerColor, backgroundColor],
            stops: silverShimmerGradient.stops,
            begin: silverShimmerGradient.begin,
            end: silverShimmerGradient.end,
            tileMode: silverShimmerGradient.tileMode,
          ),
        );

  factory ShimmerArea.fromTheme({
    Key? key,
    ShimmerStyle? style,
    required BuildContext context,
    Widget? child,
  }) {
    ShimmerStyle defaultStyle = ShimmerStyle.defaultStyle(context);
    defaultStyle = defaultStyle.merge(Theme.of(context).extension<ShimmerStyle>());
    defaultStyle = defaultStyle.merge(style);

    return ShimmerArea.fromColors(
      key: key,
      backgroundColor: defaultStyle.backgroundColor!,
      shimmerColor: defaultStyle.shimmerColor!,
      child: child,
    );
  }

  static const silverShimmerGradient = LinearGradient(
    colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1, -0.3),
    end: Alignment(1, 0.3),
    // ignore: avoid_redundant_argument_types
    tileMode: TileMode.clamp,
  );

  @override
  ShimmerAreaState createState() => ShimmerAreaState();
}

class ShimmerAreaState extends State<ShimmerArea> with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerController;

  Listenable get shimmerChanges => _shimmerController;

  LinearGradient get gradient => LinearGradient(
        colors: widget.gradient.colors,
        stops: widget.gradient.stops,
        begin: widget.gradient.begin,
        end: widget.gradient.end,
        transform: _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized => (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject()! as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    RenderBox shimmerBox = context.findRenderObject()! as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({
    required this.slidePercent,
  });


  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}
