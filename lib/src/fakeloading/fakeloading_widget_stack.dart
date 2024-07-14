part of 'fakeloading_widget.dart';

class _FakeloadingWidget extends FakeloadingWidget {

  /// holds [replacement] and [child] loaded at the same time
  ///
  /// Useful, if the [loading] should react to [child] callbacks and [child] has no Controller class.
  ///
  /// This is relatively expensive, as both widgets stay loaded in an [Offstage]
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
