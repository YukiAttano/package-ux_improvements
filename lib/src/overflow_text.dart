import "package:flutter/material.dart";

class OverflowText
    extends StatelessWidget {
  final String text;
  final TextStyle?
      style;
  final int?
      maxLines;
  final TextOverflow?
      overflow;

  final TextAlign
      textAlign;
  final TextDirection?
      textDirection;
  final TextScaler
      textScaler;
  final String?
      ellipsis;
  final Locale?
      locale;
  final StrutStyle?
      strutStyle;
  final TextWidthBasis
      textWidthBasis;
  final TextHeightBehavior?
      textHeightBehavior;

  final Widget Function(
          bool
              hasOverflow)
      builder;

  const OverflowText({
    super.key,
    required this.text,
    required this.builder,
    this.style,
    this.maxLines,
    this.overflow,
    TextAlign?
        textAlign,
    this.textDirection,
    TextScaler?
        textScaler,
    this.ellipsis,
    this.locale,
    this.strutStyle,
    TextWidthBasis?
        textWidthBasis,
    this.textHeightBehavior,
  })  : textAlign =
            textAlign ??
                TextAlign.start,
        textScaler =
            textScaler ??
                TextScaler.noScaling,
        textWidthBasis =
            textWidthBasis ??
                TextWidthBasis.parent;

  bool _hasOverflow(
      BoxConstraints
          constraints,
      TextDirection
          direction) {
    TextPainter
        painter =
        TextPainter(
      textDirection:
          direction,
      textAlign:
          textAlign,
      text: TextSpan(
          text:
              text,
          style:
              style,
          locale:
              locale),
      maxLines:
          maxLines,
      ellipsis:
          ellipsis,
      locale:
          locale,
      strutStyle:
          strutStyle,
      textWidthBasis:
          textWidthBasis,
      textHeightBehavior:
          textHeightBehavior,
      textScaler:
          textScaler,
    );

    painter.layout(
        minWidth:
            constraints
                .minWidth,
        maxWidth:
            constraints
                .maxWidth);

    return painter
        .didExceedMaxLines;
  }

  @override
  Widget build(
      BuildContext
          context) {
    TextDirection
        direction =
        Directionality.of(
            context);

    return LayoutBuilder(
      builder: (context,
          constraints) {
        bool
            hasOverflow =
            _hasOverflow(
                constraints,
                direction);

        return builder(
            hasOverflow);
      },
    );
  }
}
