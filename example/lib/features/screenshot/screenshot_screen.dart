import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class ScreenshotScreen extends StatefulWidget {
  const ScreenshotScreen({super.key});

  @override
  State<ScreenshotScreen> createState() => _ScreenshotScreenState();
}

class _ScreenshotScreenState extends State<ScreenshotScreen> {
  final ScreenshotBoundaryController _controller = ScreenshotBoundaryController();

  ScreenshotImage? _image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _onScreenshot,
          child: Text("Screenshot"),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ScreenshotBoundary(
                  controller: _controller,
                  child: const FittedBox(
                    fit: BoxFit.cover,
                    child: _AnimatedLogo(),
                  ),
                ),
              ),
              Expanded(
                child: _Image(data: _image?.data),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _onScreenshot() async {
    ScreenshotImage image = await _controller.takeScreenshot(pixelRatio: 5);

    if (!mounted) return;
    setState(() => _image = image);
  }
}

class _Image extends StatelessWidget {
  final ByteData? data;

  const _Image({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null) return const SizedBox();

    return Image.memory(data!.buffer.asUint8List());
  }
}

class _AnimatedLogo extends StatefulWidget {
  const _AnimatedLogo({super.key});

  @override
  State<_AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<_AnimatedLogo> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));

  @override
  void initState() {
    super.initState();

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: const FlutterLogo(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
