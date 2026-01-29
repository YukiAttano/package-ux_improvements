import "package:flutter/cupertino.dart";

class CupertinoSliverRefreshControlConfiguration {
  final double refreshTriggerPullDistance;

  final double refreshIndicatorExtent;

  final RefreshControlIndicatorBuilder? builder;

  static const double _defaultRefreshTriggerPullDistance = 100;
  static const double _defaultRefreshIndicatorExtent = 60;

  /// see [CupertinoSliverRefreshControl] for all descriptions.
  ///
  /// defaults adopted from there.
  const CupertinoSliverRefreshControlConfiguration({
    this.refreshTriggerPullDistance = _defaultRefreshTriggerPullDistance,
    this.refreshIndicatorExtent = _defaultRefreshIndicatorExtent,
    this.builder = CupertinoSliverRefreshControl.buildRefreshIndicator,
  });
}
