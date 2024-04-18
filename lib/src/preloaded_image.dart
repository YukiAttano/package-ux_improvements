import 'package:flutter/material.dart';

/// Preloads the image file to size the layout according to the image and available space.
/// This allows an ink animation to be exactly on the image and not spreading over it.
class PreloadedImage extends StatefulWidget {
  /// [DecorationImage.image] is the resolved image.
  /// after the resolving, [image] is placed in [decoration].
  /// The separation of the image is done for convenience.
  final DecorationImage image;

  final ImageConfiguration configuration;
  final BorderRadius? borderRadius;

  /// [BoxDecoration.borderRadius] and [BoxDecoration.image] are ignored
  final BoxDecoration decoration;

  final BoxFit boxFit;

  final Widget loading;

  final void Function()? onPressed;

  const PreloadedImage({
    super.key,
    required this.image,
    ImageConfiguration? configuration,
    this.borderRadius,
    BoxDecoration? decoration,
    BoxFit? boxFit,
    Widget? loading,
    this.onPressed,
  })  : configuration = configuration ?? ImageConfiguration.empty,
        decoration = decoration ?? const BoxDecoration(),
        boxFit = boxFit ?? BoxFit.contain,
        loading = _loading;

  static const _loading = Center(child: CircularProgressIndicator());

  @override
  State<PreloadedImage> createState() => _PreloadedImageState();
}

class _PreloadedImageState extends State<PreloadedImage> {
  ImageStream? _stream;

  Size? _size;

  @override
  void initState() {
    super.initState();
    _requestImage();
  }

  void _requestImage() {
    final stream = widget.image.image.resolve(widget.configuration);

    stream.addListener(
      ImageStreamListener((image, synchronousCall) {
        setState(() => _size = Size(image.image.width.toDouble(), image.image.height.toDouble()));
      }),
    );

    _stream = stream;
  }

  @override
  Widget build(BuildContext context) {
    if (_size != null) {
      return LayoutBuilder(
        builder: (context, constraints) {
          final sizes = applyBoxFit(widget.boxFit, _size!, constraints.biggest);

          return InkWell(
            borderRadius: widget.borderRadius,
            onTap: widget.onPressed,
            child: Ink(
              width: sizes.destination.width,
              height: sizes.destination.height,
              decoration: BoxDecoration(
                color: widget.decoration.color,
                gradient: widget.decoration.gradient,
                shape: widget.decoration.shape,
                border: widget.decoration.border,
                boxShadow: widget.decoration.boxShadow,
                backgroundBlendMode: widget.decoration.backgroundBlendMode,
                borderRadius: widget.borderRadius,
                image: widget.image,
              ),
            ),
          );
        },
      );
    }

    return widget.loading;
  }
}
