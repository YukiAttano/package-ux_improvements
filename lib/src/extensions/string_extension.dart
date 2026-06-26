import "package:flutter/widgets.dart";

class StringSize {
  final double minIntrinsicWidth;
  final double maxIntrinsicWidth;

  final double height;

  Size get minIntrinsicSize => Size(minIntrinsicWidth, height);

  Size get maxIntrinsicSize => Size(maxIntrinsicWidth, height);

  /// For all parameter, see [TextPainter]
  const StringSize({
    required this.minIntrinsicWidth,
    required this.maxIntrinsicWidth,
    required this.height,
  });
}

extension StringExtension on String {
  /// Convenience method to update [painter]
  ///
  /// Will update all fields in the [painter], when provided, and optionally computes a layout
  StringSize measure({
    required TextPainter painter,
    BoxConstraints constraints = const BoxConstraints(),
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
    direction ??= painter.textDirection;
    textScaler ??= painter.textScaler;
    locale ??= painter.locale;
    style ??= painter.text?.style;
    textAlign ??= painter.textAlign;
    maxLines ??= painter.maxLines;
    ellipsis ??= painter.ellipsis;
    strutStyle ??= painter.strutStyle;
    textWidthBasis ??= painter.textWidthBasis;
    textHeightBehavior ??= painter.textHeightBehavior;

    painter.text = TextSpan(text: this, style: style, locale: locale);

    painter.textDirection = direction;
    painter.textScaler = textScaler;
    painter.textAlign = textAlign;
    painter.maxLines = maxLines;
    painter.ellipsis = ellipsis;
    painter.strutStyle = strutStyle;
    painter.textWidthBasis = textWidthBasis;
    painter.textHeightBehavior = textHeightBehavior;

    painter.layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);

    return StringSize(
      minIntrinsicWidth: painter.minIntrinsicWidth,
      maxIntrinsicWidth: painter.maxIntrinsicWidth,
      height: painter.height,
    );
  }
}
