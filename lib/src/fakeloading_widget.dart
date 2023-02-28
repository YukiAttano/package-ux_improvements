import 'dart:async';

import 'package:flutter/material.dart';

class FakeloadingWidget extends StatefulWidget {
  final bool loading;
  final Duration duration;
  final Widget replacement;
  final Widget child;
  final bool maintainState;

  const FakeloadingWidget({Key? key, required this.loading, this.duration = const Duration(milliseconds: 500), this.replacement = const CircularProgressIndicator(), required this.child, this.maintainState = false})
      : super(key: key);

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
      Future.delayed(
        widget.duration,
            () {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        },
      );
    }
  }
}
