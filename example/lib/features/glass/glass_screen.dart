import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class GlassScreen extends StatefulWidget {
  const GlassScreen({super.key});

  @override
  State<GlassScreen> createState() => _GlassScreenState();
}

class _GlassScreenState extends State<GlassScreen> {
  double _opacity = 1;
  double _elevation = 0;
  double _sigma = 10;
  Color? _color;
  bool _hasBorder = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Settings(
          opacity: _opacity,
          onChangeOpacity: _onChangeOpacity,
          elevation: _elevation,
          onChangeElevation: _onChangeElevation,
          sigma: _sigma,
          onChangeSigma: _onChangeSigma,
          color: _color,
          onChangeColor: _onChangeColor,
          hasBorder: _hasBorder,
          onChangeBorder: _onChangeBorder,
        ),
        Text("To fully experience the Glassmorphism, try out the package yourself. The glass itself has a color and tint color to play with while the Card itself allows a third color"),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              FlutterLogo(
                size: 200,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GlassCard(
                    style: GlassCardStyle(
                      shape: _hasBorder
                          ? GlassCardStyle.defaultBorder(color: _color, useMaterial3: Theme.of(context).useMaterial3)
                          : GlassCardStyle.defaultBorder().copyWith(side: BorderSide.none),
                      color: _color,
                      opacity: _opacity,
                      elevation: _elevation,
                      containerStyle: GlassContainerStyle(
                        sigmaX: _sigma,
                        sigmaY: _sigma,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("This is a GlassCard"),
                    ),
                  ),
                  const Divider(color: Colors.transparent),
                  GlassContainer(
                    style: GlassContainerStyle(
                      color: _color,
                      opacity: _opacity,
                      sigmaX: _sigma,
                      sigmaY: _sigma,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("This is a GlassContainer"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onChangeOpacity(double value) {
    setState(() => _opacity = value);
  }

  void _onChangeElevation(double value) {
    setState(() => _elevation = value);
  }

  void _onChangeSigma(double value) {
    setState(() => _sigma = value);
  }

  void _onChangeColor(Color value) {
    setState(() => _color = value);
  }

  void _onChangeBorder(bool? value) {
    setState(() => _hasBorder = value ?? false);
  }
}

class _Settings extends StatelessWidget {
  final double opacity;
  final void Function(double opacity)? onChangeOpacity;
  final double elevation;
  final void Function(double elevation)? onChangeElevation;
  final double sigma;
  final void Function(double sigma)? onChangeSigma;
  final Color? color;
  final void Function(Color color)? onChangeColor;
  final bool hasBorder;
  final void Function(bool? border)? onChangeBorder;

  const _Settings({
    super.key,
    this.opacity = 1,
    this.onChangeOpacity,
    this.elevation = 0,
    this.onChangeElevation,
    this.sigma = 10,
    this.onChangeSigma,
    this.color,
    this.onChangeColor,
    this.hasBorder = true,
    this.onChangeBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Column(
            children: [
              Row(
                children: [
                  Text("Opacity (${opacity.toStringAsFixed(2)})"),
                  Flexible(
                    child: Slider(
                      value: opacity,
                      onChanged: onChangeOpacity,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Elevation (${elevation.toStringAsFixed(0)})"),
                  Flexible(
                    child: Slider(
                      label: elevation.toString(),
                      max: 10,
                      divisions: 10,
                      value: elevation,
                      onChanged: onChangeElevation,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text("sigma (${sigma.toStringAsFixed(1)})"),
                  Flexible(
                    child: Slider(
                      label: sigma.toString(),
                      max: 20,
                      divisions: 40,
                      value: sigma,
                      onChanged: onChangeSigma,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CheckboxListTile(
                title: Text("Border"),
                value: hasBorder,
                onChanged: onChangeBorder,
              ),
              ElevatedButton(
                onPressed: onChangeColor != null ? _onRandomColor : null,
                child: Text("Random Color"),
              ),
              Visibility(
                visible: color != null,
                child: SelectableText("${color?.red} ${color?.green} ${color?.blue}"),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _onRandomColor() {
    assert(onChangeColor != null, "provide onChangeColor");
    Random r = Random();

    onChangeColor!(Color.fromARGB(255, r.nextInt(255), r.nextInt(255), r.nextInt(255)));
  }
}
