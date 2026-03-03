import "package:flutter/material.dart";
import "package:flutter/scheduler.dart";

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

  final ImageConfiguration? configuration;

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
    this.configuration,
    required this.builder,
    this.errorBuilder,
    this.chunkBuilder,
    BoxFit? boxFit,
  }) : boxFit = boxFit ?? BoxFit.contain;

  @override
  State<RawPreloadedImage> createState() => _RawPreloadedImageState();
}

class _RawPreloadedImageState extends State<RawPreloadedImage> {
  ImageStream? _stream;
  ImageInfo? _imageInfo;

  Size? _size;

  late DisposableBuildContext<State<RawPreloadedImage>> _scrollAwareContext;
  _ImageState _imageState = _ImageState.LOADING;

  late Widget _child;

  late final ImageStreamListener _listener = ImageStreamListener(
    _onBuildImage,
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

    _scrollAwareContext = DisposableBuildContext<State<RawPreloadedImage>>(this);

    _buildChild();
  }

  @override
  void didUpdateWidget(covariant RawPreloadedImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.image != widget.image || oldWidget.configuration != widget.configuration) {
      _resolveImage();
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
      _resolveImage();
    }
  }

  @override
  void didChangeDependencies() {
    _resolveImage();

    super.didChangeDependencies();
  }

  void _resolveImage() {
    ScrollAwareImageProvider provider = ScrollAwareImageProvider<Object>(
      context: _scrollAwareContext,
      imageProvider: widget.image,
    );
    ImageStream imageStream = provider.resolve(widget.configuration ?? createLocalImageConfiguration(context));

    _updateSourceStream(imageStream);
  }

  void _updateSourceStream(ImageStream stream) {
    if (_stream?.key == stream.key) return;

    if (_stream != null) {
      _stream!.removeListener(_listener);
      _stream!.removeListener(_stateListener);
    }

    stream.addListener(_stateListener);
    stream.addListener(_listener);

    _stream = stream;
  }

  @override
  void reassemble() {
    // in case the image cache was flushed
    _resolveImage();
    super.reassemble();
  }

  void _replaceImage({required ImageInfo? info}) {
    ImageInfo? o = _imageInfo;
    SchedulerBinding.instance.addPostFrameCallback((_) => o?.dispose(), debugLabel: "RawPreloadedImage.disposeOldInfo");
    _imageInfo = info;
  }

  @override
  Widget build(BuildContext context) {
    return _child;
  }

  void _buildChild() {
    _child = _size == null ? widget.builder(null, null) : _buildLoadedImageChild();
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

  void _onBuildImage(ImageInfo image, bool synchronousCall) {
    if (context.mounted) {
      setState(() {
        _replaceImage(info: image);
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
    _replaceImage(info: null);
    _scrollAwareContext.dispose();
    super.dispose();
  }
}
