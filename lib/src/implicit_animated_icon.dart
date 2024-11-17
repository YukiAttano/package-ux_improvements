import 'package:flutter/material.dart';

/// [AnimatedIcon] but simpler to use as it handles the Animation logic internally
class ImplicitAnimatedIcon extends StatefulWidget {
  final AnimatedIconData icon;
  final bool isStarted;
  final Duration duration;
  final Color? color;
  final double? size;
  final String? semanticLabel;
  final TextDirection? textDirection;

  const ImplicitAnimatedIcon({
    super.key,
    required this.icon,
    required this.isStarted,
    this.duration = const Duration(milliseconds: 300),
    this.color,
    this.size,
    this.semanticLabel,
    this.textDirection,
  });

  @override
  State<ImplicitAnimatedIcon> createState() => _ImplicitAnimatedIconState();
}

class _ImplicitAnimatedIconState extends State<ImplicitAnimatedIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _initController();
  }

  @override
  void didUpdateWidget(covariant ImplicitAnimatedIcon oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }

    bool goesForward = _controller.status == AnimationStatus.forward;
    bool isCompleted = _controller.status == AnimationStatus.completed;

    bool started = goesForward || isCompleted;

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
      semanticLabel: widget.semanticLabel,
      size: widget.size,
      color: widget.color,
      textDirection: widget.textDirection,
      icon: widget.icon,
      progress: _controller,
    );
  }

  void _initController() {
    _controller = AnimationController(
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
