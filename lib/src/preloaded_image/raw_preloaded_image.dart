import "package:flutter/material.dart";

import "preloaded_image.dart";

enum _ImageState {
  LOADING,
  LOADED,
  ERROR,
  CHUNK;
}

/// [sizes] and [constraints] is null if the image is not loaded
typedef RawPreloadedImageBuilder = Widget Function(FittedSizes? sizes, BoxConstraints? constraints);

class RawPreloadedImage extends StatefulWidget {
  final ImageProvider image;

  final ImageConfiguration configuration;

  /// called with all parameter set to null if the image is not loaded
  /// and only with values if the image was loaded
  final RawPreloadedImageBuilder builder;

  final ImageErrorWidgetBuilder? errorBuilder;

  final Widget Function(ImageChunkEvent event)? chunkBuilder;

  /// controls how the reported size should be fit in its parent, defaults to [BoxFit.contain]
  ///
  /// access [FittedSizes.source] for the resolved original image size
  /// and [FittedSizes.destination] for the converted sizes with [boxFit] applied
  final BoxFit boxFit;

  /// Preloads the image provider to size the layout according to the image and available space.
  ///
  /// This allows an ink animation to be exactly on the image and not spreading over it for example.
  ///
  /// For a more general approach, see [PreloadedImage]
  const RawPreloadedImage({
    super.key,
    required this.image,
    ImageConfiguration? configuration,
    required this.builder,
    this.errorBuilder,
    this.chunkBuilder,
    BoxFit? boxFit,
  })  : configuration = configuration ?? ImageConfiguration.empty,
        boxFit = boxFit ?? BoxFit.contain;

  @override
  State<RawPreloadedImage> createState() => _RawPreloadedImageState();
}

class _RawPreloadedImageState extends State<RawPreloadedImage> {
  ImageStream? _stream;

  Size? _size;

  late Widget _child;

  _ImageState _imageState = _ImageState.LOADING;

  late final ImageStreamListener _listener = ImageStreamListener(
    _onBuildChild,
    onError: widget.errorBuilder != null ? _onBuildError : null,
    onChunk: widget.chunkBuilder != null ? _onBuildChunk : null,
  );

  late final ImageStreamListener _stateListener = ImageStreamListener(
    (_, __) => _onStateChange(_ImageState.LOADED),
    onError: (_, __) => _onStateChange(_ImageState.ERROR),
    onChunk: (_) => _onStateChange(_ImageState.CHUNK),
  );

  /// keep track of the current image state to call the correct builder on changes
  // ignore: use_setters_to_change_properties .
  void _onStateChange(_ImageState state) {
    // don't use setState here to avoid rebuilds
    _imageState = state;
  }

  @override
  void initState() {
    super.initState();

    _buildChild();
    _requestImage();
  }

  @override
  void didUpdateWidget(covariant RawPreloadedImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.image != widget.image || oldWidget.configuration != widget.configuration) {
      _requestImage();
    }

    if (oldWidget.builder != widget.builder || oldWidget.boxFit != widget.boxFit) {
      switch (_imageState) {
        case _ImageState.LOADING:
        case _ImageState.LOADED:
          _buildChild();
        case _ImageState.ERROR:
        case _ImageState.CHUNK:
      }
    }

    if (oldWidget.errorBuilder != widget.errorBuilder || oldWidget.chunkBuilder != widget.chunkBuilder) {
      _requestImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }

  void _requestImage() {
    ImageStream stream = widget.image.resolve(widget.configuration);

    stream.removeListener(_listener);
    stream.removeListener(_stateListener);

    stream.addListener(_stateListener);
    stream.addListener(_listener);

    _stream = stream;
  }

  /// the loaded image as a widget.
  ///
  /// must only be accessed, if [_size] is not null.
  Widget _buildLoadedImageChild() {
    return LayoutBuilder(
      builder: (context, constraints) {
        FittedSizes sizes = applyBoxFit(widget.boxFit, _size!, constraints.biggest);

        return widget.builder(sizes, constraints);
      },
    );
  }

  void _buildChild() {
    _child = _size == null ? widget.builder(null, null) : _buildLoadedImageChild();
  }

  void _onBuildChild(ImageInfo image, bool synchronousCall) {
    if (context.mounted) {
      setState(() {
        _size = Size(image.image.width.toDouble(), image.image.height.toDouble());
        _buildChild();
      });
    }
  }

  void _onBuildError(Object error, StackTrace? stackTrace) {
    assert(widget.errorBuilder != null, "errorBuilder must be provided");
    if (context.mounted) {
      setState(() {
        _child = widget.errorBuilder!(context, error, stackTrace);
      });
    }
  }

  void _onBuildChunk(ImageChunkEvent event) {
    assert(widget.chunkBuilder != null, "chunkBuilder must be provided");
    if (context.mounted) {
      setState(() {
        _child = widget.chunkBuilder!(event);
      });
    }
  }

  @override
  void dispose() {
    _stream?.removeListener(_stateListener);
    _stream?.removeListener(_listener);
    super.dispose();
  }
}

/*
import "package:flutter/material.dart";

import "raw_preloaded_image.dart";

/// Preloads the image file to size the layout according to the image and available space.
///
/// This allows an ink animation to be exactly on the image and not spreading over it.
class PreloadedImage extends StatelessWidget {
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

  /// The fit for the ink widget in his parent.
  ///
  /// defaults to [BoxFit.contain] which allows to size the ink animation to its [decoration]
  ///
  /// if set to [BoxFit.fill], it will expand the ink animation area but not the [decoration]
  /// configure [DecorationImage.fit] to directly control how the image is sized inside its ink container.
  final BoxFit boxFit;

  /// only effects [child]
  final EdgeInsets? padding;

  /// positioned above the image
  final Widget? child;

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
    this.padding,
    this.child,
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
    EdgeInsets? padding,
    Widget? child,
  }) : this.builder(
          key: key,
          image: image,
          configuration: configuration,
          builder: (image) => _loadingBuilder(image, loading ?? _loading),
          borderRadius: borderRadius,
          decoration: decoration,
          boxFit: boxFit,
          onPressed: onPressed,
          padding: padding,
          child: child,
        );

  static const _loading = Center(child: CircularProgressIndicator());

  static Widget _loadingBuilder(Widget? image, Widget loading) {
    return image ?? loading;
  }

  @override
  Widget build(BuildContext context) {
    return RawPreloadedImage(
      image: image.image,
      builder: (sizes, constraints) {
        if (sizes == null) return builder(null);

        print("BUILD");
        return builder(
          InkWell(
            borderRadius: borderRadius,
            onTap: onPressed,
            child: Ink(
              width: sizes.destination.width,
              height: sizes.destination.height,
              padding: padding,
              decoration: BoxDecoration(
                color: decoration.color,
                gradient: decoration.gradient,
                shape: decoration.shape,
                border: decoration.border,
                boxShadow: decoration.boxShadow,
                backgroundBlendMode: decoration.backgroundBlendMode,
                borderRadius: borderRadius,
                image: image,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

 */
