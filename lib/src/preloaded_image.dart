import 'package:flutter/material.dart';

/// Preloads the image file to size the layout according to the image and available space.
///
/// This allows an ink animation to be exactly on the image and not spreading over it.
class PreloadedImage extends StatefulWidget {
  /// builder used to allow implementations of animations
  ///
  /// if [image] is null, the image is not loaded yet.
  /// if [image] is not null, it represents the full widget to display the image with all defined settings.
  final Widget Function(Widget? image) builder;

  /// [DecorationImage.image] is the resolved image.
  /// after the resolving, [image] is placed in [decoration].
  /// The separation of the image is done for convenience.
  final DecorationImage image;

  final ImageConfiguration configuration;
  final BorderRadius? borderRadius;

  /// [BoxDecoration.borderRadius] and [BoxDecoration.image] are ignored
  final BoxDecoration decoration;

  final BoxFit boxFit;

  final void Function()? onPressed;

  /// allows the full control of the image widget
  /// all parameter are only effective on the loaded image.
  const PreloadedImage.builder({
    super.key,
    required this.builder,
    required this.image,
    ImageConfiguration? configuration,
    this.borderRadius,
    BoxDecoration? decoration,
    BoxFit? boxFit,
    this.onPressed,
  })  : configuration = configuration ?? ImageConfiguration.empty,
        decoration = decoration ?? const BoxDecoration(),
        boxFit = boxFit ?? BoxFit.contain;

  /// replaces the image with a [loading] widget until it is fully loaded
  PreloadedImage({
    Key? key,
    required DecorationImage image,
    ImageConfiguration? configuration,
    BorderRadius? borderRadius,
    BoxDecoration? decoration,
    BoxFit? boxFit,
    Widget? loading,
    void Function()? onPressed,
  }) : this.builder(
          key: key,
          image: image,
          configuration: configuration,
          builder: (image) => _loadingBuilder(image, loading ?? _loading),
          borderRadius: borderRadius,
          decoration: decoration,
          boxFit: boxFit,
          onPressed: onPressed,
        );

  static const _loading = Center(child: CircularProgressIndicator());

  static Widget _loadingBuilder(Widget? image, Widget loading) {
    return image ?? loading;
  }

  @override
  State<PreloadedImage> createState() => _PreloadedImageState();
}

class _PreloadedImageState extends State<PreloadedImage> {
  ImageStream? _stream;

  Size? _size;

  late Widget _child;

  late final ImageStreamListener _listener = ImageStreamListener((image, synchronousCall) {
    if (context.mounted) {
      setState(() {
        _size = Size(image.image.width.toDouble(), image.image.height.toDouble());
        _buildChild();
      });
    }
  });

  @override
  void initState() {
    super.initState();

    _buildChild();
    _requestImage();
  }

  @override
  void didUpdateWidget(covariant PreloadedImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.decoration.image != widget.decoration.image) {
      _requestImage();
    }

    if (oldWidget.builder != widget.builder ||
        oldWidget.configuration != widget.configuration ||
        oldWidget.decoration != widget.decoration ||
        oldWidget.boxFit != widget.boxFit ||
        oldWidget.borderRadius != widget.borderRadius) {
      _buildChild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }

  void _requestImage() {
    ImageStream stream = widget.image.image.resolve(widget.configuration);

    stream.addListener(_listener);

    _stream = stream;
  }

  void _buildChild() {
    _child = widget.builder(_size == null ? null : _buildLoadedImageChild());
  }

  /// the loaded image as a widget.
  ///
  /// must only be accessed, if [_size] is not null.
  Widget _buildLoadedImageChild() {
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

  @override
  void dispose() {
    _stream?.removeListener(_listener);
    super.dispose();
  }
}
