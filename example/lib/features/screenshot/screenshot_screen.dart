import 'dart:typed_data';

import 'package:example/shared/widgets/number_field.dart';
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

  int? _pixelRatio;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          _Settings(
            pixelRatio: _pixelRatio,
            onPixelRatioChanged: _onPixelRatioChanged,
            onScreenshot: _onScreenshot,
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
                  child: _Image(
                    data: _image?.data,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onScreenshot() async {
    double ratio = _pixelRatio?.toDouble() ?? 1;
    if (ratio <= 0) ratio = 0.1;
    ScreenshotImage image = await _controller.takeScreenshot(pixelRatio: ratio);

    if (!mounted) return;
    setState(() => _image = image);
  }

  void _onPixelRatioChanged(int? number) {
    setState(() => _pixelRatio = number);
  }
}

class _Settings extends StatelessWidget {
  final int? pixelRatio;
  final void Function(int? pixelRatio)? onPixelRatioChanged;
  final void Function()? onScreenshot;

  const _Settings({super.key, this.pixelRatio, this.onPixelRatioChanged, this.onScreenshot});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: NumberField(
            label: "Pixel Ratio",
            currentNumber: pixelRatio,
            onChanged: onPixelRatioChanged,
          ),
        ),
        const VerticalDivider(),
        ElevatedButton(
          onPressed: onScreenshot,
          child: Text("Screenshot"),
        ),
      ],
    );
  }
}

class _Image extends StatelessWidget {
  final ByteData? data;
  final BoxFit? fit;

  const _Image({super.key, this.data, this.fit});

  @override
  Widget build(BuildContext context) {
    if (data == null) return const SizedBox();

    return Image.memory(
      data!.buffer.asUint8List(),
      fit: fit,
    );
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
