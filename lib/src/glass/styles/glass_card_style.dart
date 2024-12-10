import "dart:ui";

import "package:flutter/material.dart";

import "../../../ux_improvements.dart";

class GlassCardStyle extends ThemeExtension<GlassCardStyle> {
  final ShapeBorder? shape;
  final Color? color;
  final double? opacity;
  final double? elevation;
  final Clip? clipBehavior;
  final GlassContainerStyle? containerStyle;

  const GlassCardStyle({
    this.shape,
    this.color,
    this.opacity,
    this.elevation,
    this.clipBehavior,
    this.containerStyle,
  });

  factory GlassCardStyle.fallback(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme scheme = theme.colorScheme;

    ShapeBorder? shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(theme.useMaterial3 ? 12 : 4)),
      side: BorderSide(color: Colors.black.withOpacity(0.2))
    );

    Color color = scheme.primaryContainer;
    double opacity = 0.1;
    double elevation = 0;

    return GlassCardStyle(
      shape: shape,
      color: color,
      opacity: opacity,
      elevation: elevation,
      clipBehavior: Clip.hardEdge,
    );
  }

  factory GlassCardStyle.of(BuildContext context, [GlassCardStyle? style]) {
    GlassCardStyle s = GlassCardStyle.fallback(context);
    s = s.merge(Theme.of(context).extension<GlassCardStyle>());
    s = s.merge(style);

    return s;
  }

  @override
  GlassCardStyle copyWith({
    ShapeBorder? shape,
    Color? color,
    double? opacity,
    double? elevation,
    Clip? clipBehavior,
    GlassContainerStyle? containerStyle,
  }) {
    return GlassCardStyle(
      shape: shape ?? this.shape,
      color: color ?? this.color,
      opacity: opacity ?? this.opacity,
      elevation: elevation ?? this.elevation,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      containerStyle: containerStyle ?? this.containerStyle,
    );
  }

  GlassCardStyle merge(ThemeExtension<GlassCardStyle>? other) {
    if (other is! GlassCardStyle) return this;

    return copyWith(
      shape: other.shape,
      color: other.color,
      opacity: other.opacity,
      elevation: other.elevation,
      clipBehavior: other.clipBehavior,
      containerStyle: other.containerStyle,
    );
  }

  @override
  GlassCardStyle lerp(covariant ThemeExtension<GlassCardStyle>? other, double t) {
    if (other is! GlassCardStyle) return this;

    return GlassCardStyle(
      shape: ShapeBorder.lerp(shape, other.shape, t),
      color: Color.lerp(color, other.color, t),
      opacity: lerpDouble(opacity, other.opacity, t),
      elevation: lerpDouble(elevation, other.elevation, t),
      clipBehavior: t < 0.5 ? clipBehavior : other.clipBehavior,
      containerStyle: containerStyle?.lerp(other.containerStyle, t) ?? other.containerStyle,
    );
  }
}
