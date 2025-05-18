import "package:flutter/material.dart";

class ShimmerStyle
    extends ThemeExtension<
        ShimmerStyle> {
  final Color?
      backgroundColor;
  final Color?
      shimmerColor;

  const ShimmerStyle(
      {this.backgroundColor,
      this.shimmerColor});

  factory ShimmerStyle.defaultStyle(
      BuildContext
          context) {
    ThemeData
        theme =
        Theme.of(
            context);

    return ShimmerStyle(
      backgroundColor: theme
          .colorScheme
          .surface,
      shimmerColor: theme
          .colorScheme
          .primaryContainer,
    );
  }

  @override
  ShimmerStyle copyWith(
      {Color?
          backgroundColor,
      Color?
          shimmerColor}) {
    return ShimmerStyle(
      backgroundColor:
          backgroundColor ??
              this.backgroundColor,
      shimmerColor:
          shimmerColor ??
              this.shimmerColor,
    );
  }

  ShimmerStyle merge(
      ShimmerStyle?
          style) {
    if (style ==
        null) {
      return this;
    }

    return copyWith(
      backgroundColor:
          style
              .backgroundColor,
      shimmerColor:
          style
              .shimmerColor,
    );
  }

  @override
  ThemeExtension<
          ShimmerStyle>
      lerp(
          ThemeExtension<
                  ShimmerStyle>?
              other,
          double
              t) {
    if (other
        is! ShimmerStyle) {
      return this;
    }

    return ShimmerStyle(
      backgroundColor:
          Color.lerp(
              backgroundColor,
              other
                  .backgroundColor,
              t),
      shimmerColor:
          Color.lerp(
              shimmerColor,
              other
                  .shimmerColor,
              t),
    );
  }
}
