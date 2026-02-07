import "package:flutter/material.dart";

/// will take the same space as [child] while also blocking hero animations
/// (prevents hero collisions on same tags)
///
/// This is useful for screens and pages that have a [FloatingActionButton] or another [Hero] widget
/// that overlaps with content and requires that to scroll higher.
///
/// Example
/// ```dart
/// ListView(
///   children: [
///     ListTile(),
///     ListTile(),
///     Cloak(
///       child: Scaffold.maybeOf(context)?.widget.floatingActionButton,
///     ),
///   ],
/// ),
/// ```
class Cloak extends StatelessWidget {
  final bool hide;

  /// prevents [Hero] animations
  ///
  /// if null, will prevent hero animations while [hide] is true, otherwise not.
  final bool preventHero;

  /// prevents interactions
  ///
  /// if null, will prevent interactions while [hide] is true, otherwise not.
  final bool ignorePointer;
  final Widget? child;

  const Cloak({super.key, this.hide = true, bool? preventHero, bool? ignorePointer, this.child})
      : preventHero = preventHero ?? hide,
        ignorePointer = ignorePointer ?? hide;

  @override
  Widget build(BuildContext context) {
    return Visibility.maintain(
      visible: !hide,
      child: HeroMode(
        enabled: !preventHero,
        child: IgnorePointer(
          ignoring: ignorePointer,
          child: child,
        ),
      ),
    );
  }
}
