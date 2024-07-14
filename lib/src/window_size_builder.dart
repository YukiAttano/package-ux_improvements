import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../ux_improvements.dart';

typedef Builder = Widget Function(WindowSize width, WindowSize height, Widget? child);

class WindowSizeBuilder extends StatefulWidget {
  final FlutterView? flutterView;
  final Builder builder;
  final Widget? child;

  const WindowSizeBuilder({super.key, this.flutterView, required this.builder, this.child});

  WindowSizeBuilder.id({Key? key, int id = 0, required Builder builder, Widget? child})
      : this(
          key: key,
          flutterView: WidgetsBinding.instance.platformDispatcher.view(id: id),
          builder: builder,
          child: child,
        );

  @override
  State<WindowSizeBuilder> createState() => _WindowSizeBuilderState();
}

class _WindowSizeBuilderState extends State<WindowSizeBuilder> {
  WindowSize? _width;
  WindowSize? _height;

  late Widget _child;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    MediaQuery.orientationOf(context); // subscribe to orientation changes to recalculate width and height
    FlutterView? view = widget.flutterView;

    WindowSize width;
    WindowSize height;

    if (view != null) {
      width = view.display.widthWindowSize;
      height = view.display.heightWindowSize;
    } else {
      width = WindowSize.COMPACT;
      height = WindowSize.COMPACT;
    }

    if (width != _width || height != _height) {
      _width = width;
      _height = height;

      _child = widget.builder(
        width,
        height,
        widget.child,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }
}
