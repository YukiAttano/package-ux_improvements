import "dart:async";

import "package:flutter/material.dart";

import "../../ux_improvements.dart";

part "fakeloading_widget_stack.dart";

class FakeloadingWidget extends StatefulWidget {
  static const Widget _defaultReplacement = CircularProgressIndicator();

  final bool loading;
  final Duration duration;
  final Widget Function(bool loading) builder;

  const FakeloadingWidget.builder({
    super.key,
    required this.loading,
    Duration? duration,
    required this.builder,
  }) : duration = duration ?? const Duration(milliseconds: 500);

  /// This is useful to prevent flashing loading indicator that are the result of fast Futures.
  ///
  /// Shows [replacement] for a given time [duration] if [loading] was set to true.
  /// This will show a replacement Widget for [child] if [loading] is set to true, most probably a loading indicator.
  /// if [loading] is set to false while the timer did not run for [duration], the [replacement] is still shown.
  ///
  /// If [loading] switches between true and false multiple times, while the first triggered [duration] was not finished, the timer does not reset.
  /// The user experiences one constant loading indicator.
  FakeloadingWidget({
    Key? key,
    required bool loading,
    Duration? duration,
    Widget? replacement,
    required Widget child,
    bool? maintainState,
  }) : this.builder(
          key: key,
          loading: loading,
          duration: duration,
          builder: (loading) {
            bool maintain = maintainState ?? false;

            return Visibility(
              maintainState: maintain,
              maintainSize: maintain,
              maintainAnimation: maintain,
              replacement: replacement ?? _defaultReplacement,
              visible: !loading,
              //!_isLoading && _isLoading == widget.loading,
              child: child,
            );
          },
        );

  /// preserves the space for [replacement].
  ///
  /// If all you need is a loading indicator with a minimum duration for better UX that has no child, use this constructor
  /// to preserve the space the indicator needs.
  FakeloadingWidget.reserve({
    Key? key,
    required bool loading,
    Duration? duration,
    Widget? replacement,
    bool? maintainState,
  }) : this(
          key: key,
          loading: loading,
          duration: duration,
          maintainState: maintainState,
          replacement: replacement,
          child: Visibility.maintain(
            visible: false,
            child: replacement ?? _defaultReplacement,
          ),
        );

  /// Allows shimmering above the [child]
  ///
  /// Relative expensive, as the Shimmer effect is generated in background and just gets discarded.
  FakeloadingWidget.shimmer({
    Key? key,
    required bool loading,
    Duration? duration,
    bool? maintainState,
    BlendMode blendMode = BlendMode.src,
    required Widget child,
  }) : this(
          key: key,
          loading: loading,
          duration: duration,
          maintainState: maintainState,
          replacement: Shimmer(
            key: const Key("Shimmer child"),
            blendMode: blendMode,
            child: child,
          ),
          child: Shimmer(
            key: const Key("Shimmer child"),
            blendMode: BlendMode.dst,
            child: child,
          ),
        );

  /// {@macro ux_improvements.fakeloading.fakeloading_widget_stack}
  factory FakeloadingWidget.stack({
    Key? key,
    required bool loading,
    Duration? duration,
    Widget? Function(bool loading)? replacement,
    required Widget child,
  }) = _FakeloadingWidget.stack;

  @override
  State<FakeloadingWidget> createState() => _FakeloadingWidgetState();
}

class _FakeloadingWidgetState extends State<FakeloadingWidget> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _toggleFakeloading();
  }

  @override
  void didUpdateWidget(covariant FakeloadingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    _toggleFakeloading();
  }

  @override
  Widget build(BuildContext context) {
    bool visible = !_isLoading && _isLoading == widget.loading;
    return widget.builder(!visible);
  }

  void _toggleFakeloading() {
    //if it is not loading, or loading animation already started, don't start a new loading animation
    bool startLoading = widget.loading && !_isLoading;

    if (startLoading) {
      _isLoading = startLoading;
      Future.delayed(widget.duration, () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
