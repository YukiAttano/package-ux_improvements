import 'package:flutter/material.dart';

/// [AnimatedIcon] but simpler to use as it handles the Animation logic internally
class ImplicitAnimatedIcon extends StatefulWidget {
  final AnimatedIconData icon;
  final bool isStarted;
  final Duration duration;

  const ImplicitAnimatedIcon({super.key, required this.icon, required this.isStarted, this.duration = const Duration(milliseconds: 300)});

  @override
  State<ImplicitAnimatedIcon> createState() => _ImplicitAnimatedIconState();
}

class _ImplicitAnimatedIconState extends State<ImplicitAnimatedIcon> with TickerProviderStateMixin {
  AnimationController? _animationController;

  AnimationController get _controller => _animationController!;

  @override
  void initState() {
    super.initState();

    _initController();
  }

  @override
  void didUpdateWidget(covariant ImplicitAnimatedIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) _initController();

    bool goesForward = _controller.status == AnimationStatus.forward;
    bool isCompleted = _controller.status == AnimationStatus.completed;
    bool reachedEnd = _controller.value == _controller.upperBound;

    bool started = goesForward || (isCompleted && reachedEnd);

    if (widget.isStarted != started) {
      if (widget.isStarted) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedIcon(
      icon: widget.icon,
      progress: _controller,
    );
  }

  void _initController() {
    _animationController?.dispose();

    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
      value: widget.isStarted ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
