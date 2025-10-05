import "package:flutter/widgets.dart";

import "chained_text_scaler.dart";

/// will apply a [ChainedTextScaler] to his subtree.
///
/// if the parent tree already has an [ChainedTextScaler] in its [MediaQuery], the [ChainedTextScaler.sourceScaler] is inherited.
///
/// This avoids multiplying text scaler and allows to correctly show different manual scale factor with the same
/// source scaler.
///
/// Example:
/// This nesting does not multiply `2 x 1.5 x 4` but overrides the child to x4
///
/// ```dart
/// AdaptiveTextScale.linear(
///   scaleFactor: 2,
///   child: AdaptiveTextScale.linear(
///     scaleFactor: 1.5,
///     child: AdaptiveTextScale.linear(
///       scaleFactor: 4,
///       child: SizedBox.shrink()
///     )
///   )
/// )
/// ```
///
/// This is useful, if you want your users to allow customizing the in-app text scale while also applying the
/// [SystemTextScaler] (which is delivered for Accessibility)
class AdaptiveTextScale extends StatelessWidget {
  final TextScaler scaler;

  /// if true (the default), we inherit the ancestor [ChainedTextScaler.sourceScaler].
  ///
  /// This allows to stack multiple [AdaptiveTextScale] widgets and only applying the last [scaler].
  ///
  /// If [MediaQueryData.textScaler] carries not a [ChainedTextScaler] or [merge] is false, the [MediaQueryData.textScaler] is chained.
  final bool merge;

  final Widget child;

  const AdaptiveTextScale({super.key, required this.scaler, bool? merge, required this.child}) : merge = merge ?? true;

  AdaptiveTextScale.linear({Key? key, double? scaleFactor, bool? merge, required Widget child})
      : this(key: key, scaler: TextScaler.linear(scaleFactor ?? 1), merge: merge, child: child);

  @override
  Widget build(BuildContext context) {
    MediaQueryData data = MediaQuery.of(context);
    TextScaler source = data.textScaler;
    if (merge && source is ChainedTextScaler) {
      source = source.sourceScaler;
    }

    ChainedTextScaler chainScaler = ChainedTextScaler(sourceScaler: source, chainScaler: scaler);

    return MediaQuery(
      // key is required to react to changes in the chainScaler, e.g. if Accessibility changes.
      key: ObjectKey(chainScaler),
      data: data.copyWith(textScaler: chainScaler),
      child: child,
    );
  }
}
