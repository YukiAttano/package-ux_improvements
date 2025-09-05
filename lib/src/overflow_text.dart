import "package:flutter/material.dart";

class OverflowText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;

  final TextAlign textAlign;
  final TextDirection? textDirection;
  final TextScaler? textScaler;
  final String? ellipsis;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  final Widget Function(bool hasOverflow) builder;

  const OverflowText({
    super.key,
    required this.text,
    required this.builder,
    this.style,
    this.maxLines,
    this.overflow,
    TextAlign? textAlign,
    this.textDirection,
    this.textScaler,
    this.ellipsis,
    this.locale,
    this.strutStyle,
    TextWidthBasis? textWidthBasis,
    this.textHeightBehavior,
  })  : textAlign = textAlign ?? TextAlign.start,
        textWidthBasis = textWidthBasis ?? TextWidthBasis.parent;

  bool _hasOverflow({
    required BoxConstraints constraints,
    TextStyle? style,
    TextDirection? direction,
    TextScaler? textScaler,
    Locale? locale,
  }) {
    style = this.style ?? style;
    // ignore: parameter_assignments .
    textScaler = this.textScaler ?? textScaler ?? TextScaler.noScaling;
    // ignore: parameter_assignments .
    locale = this.locale ?? locale;

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

    painter.layout(
      minWidth: constraints.minWidth,
      maxWidth: constraints.maxWidth,
    );

    bool didExceed = painter.didExceedMaxLines;

    painter.dispose();

    return didExceed;
  }

  @override
  Widget build(BuildContext context) {
    TextDirection? direction = Directionality.maybeOf(context);
    TextScaler textScaler = MediaQuery.textScalerOf(context);
    Locale? locale = Localizations.maybeLocaleOf(context);
    DefaultTextStyle style = DefaultTextStyle.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        bool hasOverflow = _hasOverflow(
          constraints: constraints,
          style: style.style,
          direction: direction,
          textScaler: textScaler,
          locale: locale,
        );

        return builder(hasOverflow);
      },
    );
  }
}
