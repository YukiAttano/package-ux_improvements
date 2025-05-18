part of "fakeloading_widget.dart";

class _FakeloadingWidget
    extends FakeloadingWidget {
  /// {@template ux_improvements.fakeloading.fakeloading_widget_stack}
  /// holds [replacement] and [child] loaded at the same time
  ///
  /// Useful, if [loading] should react to callbacks from [child] and [child] has no Controller class to separate its logic.
  ///
  /// This is relatively expensive, as both widgets stay loaded in an [Offstage].
  /// To counteract this problem, the [replacement] retrieves the [loading] information.
  ///
  /// the [child] is only visible if [loading] is false while the [replacement] is only visible if [loading] is true
  /// {@endtemplate}
  _FakeloadingWidget.stack({
    super.key,
    required super.loading,
    super.duration,
    Widget? Function(
            bool
                loading)?
        replacement,
    required Widget
        child,
  }) : super.builder(
          builder:
              (loading) {
            return _Stack(
              index: loading
                  ? 0
                  : 1,
              replacement:
                  replacement?.call(loading) ?? FakeloadingWidget._defaultReplacement,
              child:
                  child,
            );
          },
        );
}

class _Stack
    extends StatelessWidget {
  final int index;
  final Widget
      replacement;
  final Widget
      child;

  const _Stack(
      {this.index =
          0,
      required this.replacement,
      required this.child});

  @override
  Widget build(
      BuildContext
          context) {
    return IndexedStack(
      index: index,
      children: [
        replacement,
        child,
      ],
    );
  }
}
