part of 'fakeloading_widget.dart';

class _FakeloadingWidget extends FakeloadingWidget {

  /// {@template ux_improvements.fakeloading.fakeloading_widget_stack}
  /// holds [replacement] and [child] loaded at the same time
  ///
  /// Useful, if [loading] should react to callbacks from [child] and [child] has no Controller class to separate its logic.
  ///
  /// This is relatively expensive, as both widgets stay loaded in an [Offstage]
  /// {@endtemplate}
  _FakeloadingWidget.stack({
    Key? key,
    required bool loading,
    Duration? duration,
    bool? maintainState,
    Widget? replacement,
    required Widget child,
  }) : super(
          key: key,
          loading: loading,
          duration: duration,
          maintainState: maintainState,
          replacement: _Stack(
            index: 0,
            replacement: replacement ?? FakeloadingWidget._defaultReplacement,
            child: child,
          ),
          child: _Stack(
            index: 1,
            replacement: replacement ?? FakeloadingWidget._defaultReplacement,
            child: child,
          ),
        );
}

class _Stack extends StatelessWidget {
  final int index;
  final Widget replacement;
  final Widget child;

  const _Stack({this.index = 0, required this.replacement, required this.child});

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        replacement,
        child,
      ],
    );
  }
}
