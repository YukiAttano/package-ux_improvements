import "package:flutter/material.dart";
import "styles/shimmer_style.dart";

/// Controls a shimmer animation on the screen
///
/// Use a [Shimmer] Widget to display the effect or a [ShimmerBox] for a non-synchronized shimmer
///
/// Note: accessing the [ShimmerArea] inside a [TabBarView] can cause exceptions.
/// The thrown exception is caused by Flutter and seems to be caused by the swipe animation (Flutter does not correctly find the [Shimmer] inside the [ShimmerArea])
/// Example (Don't do):
/// ```dart
/// ShimmerArea(
///   child: TabBarView(
///     controller: _controller,
///     children: [
///       Page1(),
///       Page2(),
///     ]
///   ),
/// ),
/// ```
///
/// Instead introduce a [ShimmerArea] per Page.
/// That way, the Shimmer effect is correctly animated with the swipe animation of the TabBarView and does not cause errors
///
/// Example (Do this):
/// ```dart
/// TabBarView(
///   controller: _controller,
///   children: [
///     ShimmerArea(
///       Page1(),
///     ),
///     ShimmerArea(
///       Page2(),
///     )
///   ]
/// ),
/// ```
class ShimmerArea extends StatefulWidget {
  final LinearGradient gradient;
  final Duration? duration;
  final Widget child;

  const ShimmerArea({
    super.key,
    LinearGradient? gradient,
    Duration? duration,
    Widget? child,
  })  : gradient = gradient ?? silverShimmerGradient,
        duration = duration ?? const Duration(milliseconds: 1000),
        child = child ?? const SizedBox.shrink();

  ShimmerArea.fromColors({
    Key? key,
    required Color backgroundColor,
    required Color shimmerColor,
    Duration? duration,
    Widget? child,
  }) : this(
          key: key,
          gradient: LinearGradient(
            colors: [backgroundColor, shimmerColor, backgroundColor],
            stops: silverShimmerGradient.stops,
            begin: silverShimmerGradient.begin,
            end: silverShimmerGradient.end,
            tileMode: silverShimmerGradient.tileMode,
          ),
          duration: duration,
          child: child,
        );

  factory ShimmerArea.fromTheme({
    Key? key,
    ShimmerStyle? style,
    Duration? duration,
    required BuildContext context,
    Widget? child,
  }) {
    ShimmerStyle defaultStyle = ShimmerStyle.defaultStyle(context);
    defaultStyle = defaultStyle.merge(Theme.of(context).extension<ShimmerStyle>());
    defaultStyle = defaultStyle.merge(style);

    return ShimmerArea.fromColors(
      key: key,
      backgroundColor: defaultStyle.backgroundColor!,
      duration: duration,
      shimmerColor: defaultStyle.shimmerColor!,
      child: child,
    );
  }

  static const sliverColors = [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)];
  static const silverShimmerGradient = LinearGradient(
    colors: sliverColors,
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1, -0.3),
    end: Alignment(1, 0.3),
    //tileMode: TileMode.clamp,
  );

  @override
  ShimmerAreaState createState() => ShimmerAreaState();

  static ShimmerAreaState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerAreaState>();
  }
}

class ShimmerAreaState extends State<ShimmerArea> with TickerProviderStateMixin {
  late AnimationController _shimmerController;

  late ValueNotifier<Animation<double>> shimmerChanges = ValueNotifier(_shimmerController.view);

  LinearGradient get gradient => LinearGradient(
        colors: widget.gradient.colors,
        stops: widget.gradient.stops,
        begin: widget.gradient.begin,
        end: widget.gradient.end,
        transform: _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized => (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject()! as RenderBox).size;

  Offset getDescendantOffset({required RenderBox descendant, Offset offset = Offset.zero}) {
    RenderBox shimmerBox = context.findRenderObject()! as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  @override
  void initState() {
    super.initState();

    _initController();
  }

  @override
  void didUpdateWidget(covariant ShimmerArea oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _shimmerController.dispose();
      _initController();
    }
  }

  void _initController() {
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: widget.duration);

    shimmerChanges.value = _shimmerController.view;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    shimmerChanges.dispose();
    _shimmerController.dispose();
    super.dispose();
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
