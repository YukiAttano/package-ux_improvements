import "dart:ui";

import "package:flutter/material.dart";

class GlassContainerStyle extends ThemeExtension<GlassContainerStyle> {
  final Color? color;
  final double? opacity;

  final Color? tint;
  final double? tintOpacity;
  final double? tintBlurRadius;
  final BorderRadius? borderRadius;
  final Border? border;
  final double? sigmaX;
  final double? sigmaY;
  final Clip? clipBehavior;
  final Gradient? gradient;
  final BoxShape? shape;

  const GlassContainerStyle({
    this.color,
    this.opacity,
    this.tint,
    this.tintOpacity,
    this.tintBlurRadius,
    this.borderRadius,
    this.border,
    this.sigmaX,
    this.sigmaY,
    this.clipBehavior,
    this.gradient,
    this.shape,
  });

  factory GlassContainerStyle.fallback(BuildContext context) {
    Color color = Colors.white;
    double opacity = 0.1;

    Color tint = Colors.white;
    double tintOpacity = 0.3;
    double tintBlurRadius = 8;

    double sigmaX = 10;
    double sigmaY = 10;

    BorderRadius? radius; // = const BorderRadius.all(Radius.circular(0));
    Border? border; // = Border.all(color: Colors.white);

    return GlassContainerStyle(
      color: color,
      opacity: opacity,
      borderRadius: radius,
      tint: tint,
      tintBlurRadius: tintBlurRadius,
      tintOpacity: tintOpacity,
      border: border,
      sigmaX: sigmaX,
      sigmaY: sigmaY,
      clipBehavior: Clip.hardEdge,
    );
  }

  factory GlassContainerStyle.of(BuildContext context,
      [GlassContainerStyle? style]) {
    GlassContainerStyle s = GlassContainerStyle.fallback(context);
    s = s.merge(Theme.of(context).extension<GlassContainerStyle>());
    s = s.merge(style);

    return s;
  }

  @override
  GlassContainerStyle copyWith({
    Color? color,
    double? opacity,
    Color? tint,
    double? tintOpacity,
    double? tintBlurRadius,
    BorderRadius? borderRadius,
    Border? border,
    double? sigmaX,
    double? sigmaY,
    Clip? clipBehavior,
    Gradient? gradient,
    BoxShape? shape,
  }) {
    return GlassContainerStyle(
      color: color ?? this.color,
      opacity: opacity ?? this.opacity,
      tint: tint ?? this.tint,
      tintOpacity: tintOpacity ?? this.tintOpacity,
      tintBlurRadius: tintBlurRadius ?? this.tintBlurRadius,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      sigmaX: sigmaX ?? this.sigmaX,
      sigmaY: sigmaY ?? this.sigmaY,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      gradient: gradient ?? this.gradient,
      shape: shape ?? this.shape,
    );
  }

  GlassContainerStyle merge(ThemeExtension<GlassContainerStyle>? other) {
    if (other is! GlassContainerStyle) return this;

    return copyWith(
      color: other.color,
      opacity: other.opacity,
      tint: other.tint,
      tintOpacity: other.tintOpacity,
      tintBlurRadius: other.tintBlurRadius,
      borderRadius: other.borderRadius,
      border: other.border,
      sigmaX: other.sigmaX,
      sigmaY: other.sigmaY,
      clipBehavior: other.clipBehavior,
      gradient: other.gradient,
      shape: other.shape,
    );
  }

  @override
  GlassContainerStyle lerp(
      covariant ThemeExtension<GlassContainerStyle>? other, double t) {
    if (other is! GlassContainerStyle) return this;

    return GlassContainerStyle(
      color: Color.lerp(color, other.color, t),
      opacity: lerpDouble(opacity, other.opacity, t),
      tint: Color.lerp(tint, other.tint, t),
      tintOpacity: lerpDouble(tintOpacity, other.tintOpacity, t),
      tintBlurRadius: lerpDouble(tintBlurRadius, other.tintBlurRadius, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t),
      border: Border.lerp(border, other.border, t),
      sigmaX: lerpDouble(sigmaX, other.sigmaX, t),
      sigmaY: lerpDouble(sigmaY, other.sigmaY, t),
      clipBehavior: t < 0.5 ? clipBehavior : other.clipBehavior,
      gradient: Gradient.lerp(gradient, other.gradient, t),
      shape: t < 0.5 ? shape : other.shape,
    );
  }
}
