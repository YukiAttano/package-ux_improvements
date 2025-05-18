import "dart:ui";

import "package:flutter/material.dart";

import "../../../ux_improvements.dart";

class GlassCardStyle
    extends ThemeExtension<
        GlassCardStyle> {
  final ShapeBorder?
      shape;
  final Color?
      color;
  final double?
      opacity;
  final double?
      elevation;
  final Clip?
      clipBehavior;
  final GlassContainerStyle?
      containerStyle;
  final EdgeInsetsGeometry?
      margin;
  final Color?
      shadowColor;

  const GlassCardStyle({
    this.shape,
    this.color,
    this.opacity,
    this.elevation,
    this.clipBehavior,
    this.containerStyle,
    this.margin,
    this.shadowColor,
  });

  factory GlassCardStyle.fallback(
      BuildContext
          context) {
    ThemeData
        theme =
        Theme.of(
            context);
    ColorScheme
        scheme =
        theme
            .colorScheme;

    ShapeBorder?
        shape =
        defaultBorder(
            useMaterial3:
                theme.useMaterial3);

    Color color = scheme
        .primaryContainer;
    double opacity =
        0.1;
    double
        elevation =
        0;

    return GlassCardStyle(
      shape: shape,
      color: color,
      opacity:
          opacity,
      elevation:
          elevation,
      clipBehavior:
          Clip.hardEdge,
    );
  }

  factory GlassCardStyle.of(
      BuildContext
          context,
      [GlassCardStyle?
          style]) {
    GlassCardStyle
        s =
        GlassCardStyle
            .fallback(
                context);
    s = s.merge(Theme.of(
            context)
        .extension<
            GlassCardStyle>());
    s = s.merge(
        style);

    return s;
  }

  static RoundedRectangleBorder
      defaultBorder(
          {Color?
              color,
          double?
              opacity,
          bool useMaterial3 =
              true}) {
    color ??= Colors
        .black;
    opacity ??= 0.2;

    return RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(
          useMaterial3
              ? 12
              : 4)),
      side:
          BorderSide(
        color: color
            .withValues(
                alpha:
                    opacity),
        style: opacity ==
                0
            ? BorderStyle
                .none
            : BorderStyle
                .solid,
      ),
    );
  }

  @override
  GlassCardStyle
      copyWith({
    ShapeBorder?
        shape,
    Color? color,
    double? opacity,
    double?
        elevation,
    Clip?
        clipBehavior,
    GlassContainerStyle?
        containerStyle,
    EdgeInsetsGeometry?
        margin,
    Color?
        shadowColor,
  }) {
    return GlassCardStyle(
      shape: shape ??
          this.shape,
      color: color ??
          this.color,
      opacity:
          opacity ??
              this.opacity,
      elevation:
          elevation ??
              this.elevation,
      clipBehavior:
          clipBehavior ??
              this.clipBehavior,
      containerStyle:
          containerStyle ??
              this.containerStyle,
      margin: margin ??
          this.margin,
      shadowColor:
          shadowColor ??
              this.shadowColor,
    );
  }

  GlassCardStyle merge(
      ThemeExtension<
              GlassCardStyle>?
          other) {
    if (other
        is! GlassCardStyle)
      return this;

    return copyWith(
      shape: other
          .shape,
      color: other
          .color,
      opacity: other
          .opacity,
      elevation: other
          .elevation,
      clipBehavior:
          other
              .clipBehavior,
      containerStyle:
          other
              .containerStyle,
      margin: other
          .margin,
      shadowColor: other
          .shadowColor,
    );
  }

  @override
  GlassCardStyle lerp(
      covariant ThemeExtension<
              GlassCardStyle>?
          other,
      double t) {
    if (other
        is! GlassCardStyle)
      return this;

    return GlassCardStyle(
      shape: ShapeBorder
          .lerp(
              shape,
              other
                  .shape,
              t),
      color: Color.lerp(
          color,
          other
              .color,
          t),
      opacity: lerpDouble(
          opacity,
          other
              .opacity,
          t),
      elevation: lerpDouble(
          elevation,
          other
              .elevation,
          t),
      clipBehavior: t <
              0.5
          ? clipBehavior
          : other
              .clipBehavior,
      containerStyle: containerStyle?.lerp(
              other
                  .containerStyle,
              t) ??
          other
              .containerStyle,
      margin: EdgeInsetsGeometry
          .lerp(
              margin,
              other
                  .margin,
              t),
      shadowColor:
          Color.lerp(
              shadowColor,
              other
                  .shadowColor,
              t),
    );
  }
}
