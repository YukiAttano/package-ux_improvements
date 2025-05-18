import "package:flutter/material.dart";

class EndlessListView extends CustomScrollView {
  EndlessListView.builder({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.scrollBehavior,
    super.shrinkWrap,
    super.anchor,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    ChildIndexGetter? findChildIndexCallback,
    int? negativeCount,
    int? negativeStart,
    int? positiveCount,
    int? positiveStart,
    required NullableIndexedWidgetBuilder itemBuilder,
  }) : super(
          center: const Key("positive"),
          slivers: buildSliverList(
            findChildIndexCallback: findChildIndexCallback,
            negativeCount: negativeCount,
            negativeStart: negativeStart,
            positiveCount: positiveCount,
            positiveStart: positiveStart,
            itemBuilder: itemBuilder,
          ),
        );

  /// Builds an (optionally) endless list which can be scrolled in both directions.
  ///
  /// Builds from [positiveStart] [positiveCount] items or endlessly, if [positiveCount] is null.
  /// Builds from [negativeStart] [negativeCount] items or endlessly, if [negativeCount] is null.
  ///
  /// ```dart
  /// Example:
  /// positiveStart = 0;
  /// positiveCount = 5;
  /// Will build a list from 0 - 5
  ///
  /// negativeStart = -1
  /// positiveStart = 0;
  /// positiveCount = 5;
  /// Will build a list from 0 - 5 and from -1 to -infinity
  ///
  /// negativeStart = 5
  /// positiveStart = 6;
  /// positiveCount = 50;
  /// Will build a list from 6 - 50 and from 5 to -infinity
  /// ```
  ///
  /// The list always starts at [positiveStart] as the centered Widget.
  ///
  /// It is possible to define ranges where widgets are build twice (e.g. negativeStart = 5 and positiveStart = 0).
  static List<Widget> buildSliverList({
    ChildIndexGetter? findChildIndexCallback,
    int? negativeStart,
    int? negativeCount,
    int? positiveStart,
    int? positiveCount,
    required NullableIndexedWidgetBuilder itemBuilder,
  }) {
    int n = -(negativeStart ?? -1);
    int p = positiveStart ?? 0;

    return [
      SliverList.builder(
        key: const Key("negative"),
        itemCount: negativeCount,
        itemBuilder: (context, index) => itemBuilder(context, -(index + n)),
        findChildIndexCallback: findChildIndexCallback != null
            ? (key) => _findChildIndexCallback(key, findChildIndexCallback, n)
            : null,
      ),
      SliverList.builder(
        key: const Key("positive"),
        itemCount: positiveCount,
        itemBuilder: (context, index) => itemBuilder(context, index + p),
        findChildIndexCallback: findChildIndexCallback != null
            ? (key) => _findChildIndexCallback(key, findChildIndexCallback, p)
            : null,
      ),
    ];
  }

  static int? _findChildIndexCallback(
      Key key, ChildIndexGetter getter, int offset) {
    int? index = getter(key);
    return index != null ? -(index + offset) : null;
  }
}
