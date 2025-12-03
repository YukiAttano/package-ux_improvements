import "package:flutter/material.dart";

import "raw_preloaded_image.dart";

/// Preloads the image file to size the layout according to the image and available space.
///
/// This allows an ink animation to be exactly on the image and not spreading over it.
class PreloadedImage extends StatelessWidget {
  /// [DecorationImage.image] is the resolved image.
  /// after the resolving, [image] is placed in [decoration].
  /// The separation of the image is done for convenience.
  final DecorationImage image;

  /// builder used to allow implementations of animations
  ///
  /// if [image] is null, the image is not loaded yet.
  /// if [image] is not null, it represents the full widget to display the image with all defined settings.
  final Widget Function(Widget? image) builder;

  final ImageErrorWidgetBuilder? errorBuilder;

  final Widget Function(ImageChunkEvent event)? chunkBuilder;

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
  ///
  /// all parameter are only effective on the loaded image.
  ///
  /// For more customization, see [RawPreloadedImage]
  const PreloadedImage.builder({
    super.key,
    required this.image,
    ImageConfiguration? configuration,
    required this.builder,
    this.errorBuilder,
    this.chunkBuilder,
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
    ImageErrorWidgetBuilder? errorBuilder,
    Widget Function(ImageChunkEvent event)? chunkBuilder,
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
          errorBuilder: errorBuilder,
          chunkBuilder: chunkBuilder,
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
      configuration: configuration,
      boxFit: boxFit,
      builder: (sizes, constraints) {
        if (sizes == null) return builder(null);

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
      errorBuilder: errorBuilder,
      chunkBuilder: chunkBuilder,
    );
  }
}
