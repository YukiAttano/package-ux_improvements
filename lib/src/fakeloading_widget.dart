import 'dart:async';

import 'package:flutter/material.dart';

import '../ux_improvements.dart';

class FakeloadingWidget extends StatefulWidget {
  static const Widget _defaultReplacement = CircularProgressIndicator();

  final bool loading;
  final Duration duration;
  final Widget replacement;
  final Widget child;
  final bool maintainState;

  /// This is useful to prevent flashing loading indicator that are the result of fast Futures.
  ///
  /// Shows [replacement] for a given time [duration] if [loading] was set to true.
  /// This will show a replacement Widget for [child] if [loading] is set to true, most probably a loading indicator.
  /// if [loading] is set to false while the timer did not run for [duration], the [replacement] is still shown.
  ///
  /// If [loading] switches between true and false multiple times, while the first triggered [duration] was not finished, the timer does not reset.
  /// The user experiences one constant loading indicator.
  const FakeloadingWidget({Key? key, required this.loading, Duration? duration, Widget? replacement, required this.child, bool? maintainState})
      : duration = duration ?? const Duration(milliseconds: 500),
        replacement = replacement ?? _defaultReplacement,
        maintainState = maintainState ?? false,
        super(key: key);

  /// preserves the space for [replacement].
  ///
  /// If all you need is a loading indicator with a minimum duration for better UX that has no [child], use this constructor
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
  /// Relative expensive, as the Shimmer effect is generated in background and just gets discarded
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
    return Visibility(
      maintainState: widget.maintainState,
      maintainSize: widget.maintainState,
      maintainAnimation: widget.maintainState,
      replacement: widget.replacement,
      visible: !_isLoading && _isLoading == widget.loading,
      //only show child if loading animation has ended and widget.loading is also false
      child: widget.child,
    );
  }

  void _toggleFakeloading() {
    bool startLoading = widget.loading && !_isLoading; //if it is not loading, or loading animation already started, don't start a new loading animation

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
