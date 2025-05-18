import "package:flutter/material.dart";

class RefreshIndicatorConfiguration {
  final double
      displacement;

  final double
      edgeOffset;

  final Color?
      color;

  final Color?
      backgroundColor;

  /// {@macro flutter.progress_indicator.ProgressIndicator.semanticsLabel}
  final String?
      semanticsLabel;

  /// {@macro flutter.progress_indicator.ProgressIndicator.semanticsValue}
  final String?
      semanticsValue;

  final double
      strokeWidth;

  final RefreshIndicatorTriggerMode
      triggerMode;

  /// see [RefreshIndicator] for all descriptions.
  ///
  /// defaults copied from there.
  const RefreshIndicatorConfiguration({
    this.displacement =
        40.0,
    this.edgeOffset =
        0.0,
    this.color,
    this.backgroundColor,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeWidth =
        RefreshProgressIndicator
            .defaultStrokeWidth,
    this.triggerMode =
        RefreshIndicatorTriggerMode
            .onEdge,
  });
}
