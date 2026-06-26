import "package:flutter/material.dart";

import "string_extension.dart";

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

    if (applyTextHeight) fS *= style.height ?? 1; //kTextHeightNone;

    fS = scaler.scale(fS);

    return round ? fS.roundToDouble() : fS;
  }

  /// Creates a [TextPainter] for reuse
  ///
  /// use [StringExtension.measure] to extract useful information.
  ///
  /// must be disposed after usage
  TextPainter setupTextPainter({
    required String text,
    BoxConstraints? constraints,
    TextDirection? direction,
    TextScaler? textScaler,
    Locale? locale,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    String? ellipsis,
    StrutStyle? strutStyle,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) {
    constraints ??= const BoxConstraints.expand();

    direction ??= Directionality.maybeOf(this);
    textScaler ??= MediaQuery.textScalerOf(this);
    locale ??= Localizations.maybeLocaleOf(this);
    style ??= DefaultTextStyle.of(this).style;

    textAlign ??= TextAlign.start;
    textWidthBasis ??= TextWidthBasis.parent;

    TextPainter painter = TextPainter(
      textDirection: direction,
      textAlign: textAlign,
      text: TextSpan(text: text, style: style, locale: locale),
      maxLines: maxLines,
      ellipsis: ellipsis,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
      textScaler: textScaler,
    );

    return painter;
  }
}
