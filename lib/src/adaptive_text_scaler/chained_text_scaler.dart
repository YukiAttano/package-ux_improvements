import "package:flutter/widgets.dart";

class ChainedTextScaler extends TextScaler {
  final TextScaler sourceScaler;
  final TextScaler chainScaler;

  const ChainedTextScaler({required this.sourceScaler, required this.chainScaler});

  ChainedTextScaler.linear({required TextScaler sourceScaler, required double factor})
      : this(sourceScaler: sourceScaler, chainScaler: TextScaler.linear(factor));

  @override
  double scale(double fontSize) {
    return chainScaler.scale(sourceScaler.scale(fontSize));
  }

  @override
  double get textScaleFactor => chainScaler.scale(sourceScaler.scale(1));

  @override
  String toString() => "chained ($sourceScaler x $chainScaler)";
}
