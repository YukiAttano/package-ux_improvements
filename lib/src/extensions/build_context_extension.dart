import "package:flutter/material.dart";

extension BuildContextExtension on BuildContext {
  /// returns the current scaled text height for [fontSize]
  ///
  /// if [fontSize] is not given, the [DefaultTextStyle] is used.
  /// if that is also null, [TextTheme.bodyMedium] is used.
  ///
  /// the reserved size for a [Text] widget is based on its [TextStyle.height] value.
  /// if [applyTextHeight] is true, the returned height will match the Font metrics default height
  /// while if set to false, it will match the center of the widget.
  ///
  /// ![Text height diagram](https://flutter.github.io/assets-for-api-docs/assets/painting/text_height_diagram.png)
  ///
  /// [round] defaults to true as it seems that the [Text] size is always rounded
  double textHeight({double? fontSize, bool applyTextHeight = false, bool round = true}) {
    TextStyle style = DefaultTextStyle.of(this).style;
    TextScaler scaler = MediaQuery.textScalerOf(this);
    TextTheme textTheme = TextTheme.of(this);

    double fS = fontSize ?? style.fontSize ?? textTheme.bodyMedium?.fontSize ?? 1;

    if (applyTextHeight) fS *= style.height ?? kTextHeightNone;

    fS = scaler.scale(fS);

    return round ? fS.roundToDouble() : fS;
  }
}
