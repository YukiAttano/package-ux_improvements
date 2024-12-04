import "package:flutter/cupertino.dart" hide RefreshCallback;
import "package:flutter/material.dart";

import "cupertino_sliver_refresh_control_configuration.dart";
import "custom_scroll_view_configuration.dart";
import "refresh_indicator_configuration.dart";

class AdaptiveRefreshIndicator extends StatelessWidget {
  final EdgeInsets padding;
  final ScrollPhysics? physics;
  final RefreshCallback onRefresh;
  final RefreshIndicatorConfiguration indicatorConfig;
  final CupertinoSliverRefreshControlConfiguration cupertinoConfig;
  final CustomScrollViewConfiguration config;

  /// set this to true to always use the [RefreshIndicator], false to always use the [CupertinoSliverRefreshControl] and
  /// null to use cupertino only on [TargetPlatform.iOS] and [TargetPlatform.macOS]
  final bool? useMaterialIndicator;
  final List<Widget> slivers;

  final bool _enabled;

  /// {@template adaptive_refresh_indicator}
  /// uses the [CupertinoSliverRefreshControl] on [TargetPlatform.iOS] and [TargetPlatform.macOS] and
  /// [RefreshIndicator] on all others.
  ///
  /// The difference to [RefreshIndicator.adaptive] is, that this implementation is using a list to insert the [CupertinoSliverRefreshControl]
  /// and let it take space while it is refreshing.
  ///
  /// To use more sliver, consider adding the package:sliver_tools which has a MultiSliver widget that allows adding multiple
  /// slivers as one sliver.
  /// {@endtemplate}
  AdaptiveRefreshIndicator.slivers({
    super.key,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    RefreshCallback? onRefresh,
    RefreshIndicatorConfiguration? indicatorConfig,
    CupertinoSliverRefreshControlConfiguration? cupertinoConfig,
    CustomScrollViewConfiguration? config,
    this.useMaterialIndicator,
    bool? adaptPhysics,
    required this.slivers,
  })  : padding = padding ?? EdgeInsets.zero,
        onRefresh = onRefresh ?? _emptyRefreshCallback,
        indicatorConfig = indicatorConfig ?? const RefreshIndicatorConfiguration(),
        cupertinoConfig = cupertinoConfig ?? const CupertinoSliverRefreshControlConfiguration(),
        config = config ?? const CustomScrollViewConfiguration(),
        _enabled = onRefresh != null,
        physics = physics ?? ((adaptPhysics ?? true) ? _getAdoptedPhysics(useMaterialIndicator) : null);

  /// {@macro adaptive_refresh_indicator}
  AdaptiveRefreshIndicator({
    Key? key,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    RefreshCallback? onRefresh,
    RefreshIndicatorConfiguration? indicatorConfig,
    CupertinoSliverRefreshControlConfiguration? cupertinoConfig,
    CustomScrollViewConfiguration? config,
    bool? useMaterialIndicator,
    bool? adaptPhysics,
    required Widget sliver,
  }) : this.slivers(
          key: key,
          padding: padding,
          onRefresh: onRefresh,
          indicatorConfig: indicatorConfig,
          cupertinoConfig: cupertinoConfig,
          config: config,
          physics: physics,
          useMaterialIndicator: useMaterialIndicator,
          adaptPhysics: adaptPhysics,
          slivers: [sliver],
        );

  AdaptiveRefreshIndicator.widget({
    Key? key,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    RefreshCallback? onRefresh,
    RefreshIndicatorConfiguration? indicatorConfig,
    CupertinoSliverRefreshControlConfiguration? cupertinoConfig,
    CustomScrollViewConfiguration? config,
    bool? useMaterialIndicator,
    bool? adoptPhysics,
    required Widget child,
  }) : this(
          key: key,
          padding: padding,
          physics: physics,
          onRefresh: onRefresh,
          indicatorConfig: indicatorConfig,
          cupertinoConfig: cupertinoConfig,
          config: config,
          useMaterialIndicator: useMaterialIndicator,
          adaptPhysics: adoptPhysics,
          sliver: SliverToBoxAdapter(child: child),
        );

  AdaptiveRefreshIndicator.widgets({
    Key? key,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    bool? adoptPhysics,
    RefreshCallback? onRefresh,
    RefreshIndicatorConfiguration? indicatorConfig,
    CupertinoSliverRefreshControlConfiguration? cupertinoConfig,
    CustomScrollViewConfiguration? config,
    bool? useMaterialIndicator,
    required List<Widget> children,
  }) : this(
          key: key,
          padding: padding,
          physics: physics,
          onRefresh: onRefresh,
          indicatorConfig: indicatorConfig,
          cupertinoConfig: cupertinoConfig,
          config: config,
          useMaterialIndicator: useMaterialIndicator,
          adaptPhysics: adoptPhysics,
          sliver: SliverList.list(
            children: children,
          ),
        );

  AdaptiveRefreshIndicator.builder({
    Key? key,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    bool? adoptPhysics,
    RefreshCallback? onRefresh,
    RefreshIndicatorConfiguration? indicatorConfig,
    CupertinoSliverRefreshControlConfiguration? cupertinoConfig,
    CustomScrollViewConfiguration? config,
    bool? useMaterialIndicator,
    required NullableIndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : this(
          key: key,
          padding: padding,
          physics: physics,
          onRefresh: onRefresh,
          indicatorConfig: indicatorConfig,
          cupertinoConfig: cupertinoConfig,
          config: config,
          useMaterialIndicator: useMaterialIndicator,
          adaptPhysics: adoptPhysics,
          sliver: SliverList.builder(
            itemCount: itemCount,
            findChildIndexCallback: findChildIndexCallback,
            itemBuilder: itemBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          ),
        );

  AdaptiveRefreshIndicator.separated({
    Key? key,
    EdgeInsets? padding,
    ScrollPhysics? physics,
    bool? adoptPhysics,
    RefreshCallback? onRefresh,
    RefreshIndicatorConfiguration? indicatorConfig,
    CupertinoSliverRefreshControlConfiguration? cupertinoConfig,
    CustomScrollViewConfiguration? config,
    bool? useMaterialIndicator,
    required NullableIndexedWidgetBuilder itemBuilder,
    ChildIndexGetter? findChildIndexCallback,
    required NullableIndexedWidgetBuilder separatorBuilder,
    int? itemCount,
    bool addAutomaticKeepAlives = true,
    bool addRepaintBoundaries = true,
    bool addSemanticIndexes = true,
  }) : this(
          key: key,
          padding: padding,
          physics: physics,
          onRefresh: onRefresh,
          indicatorConfig: indicatorConfig,
          cupertinoConfig: cupertinoConfig,
          config: config,
          useMaterialIndicator: useMaterialIndicator,
          adaptPhysics: adoptPhysics,
          sliver: SliverList.separated(
            itemCount: itemCount,
            findChildIndexCallback: findChildIndexCallback,
            itemBuilder: itemBuilder,
            separatorBuilder: separatorBuilder,
            addAutomaticKeepAlives: addAutomaticKeepAlives,
            addRepaintBoundaries: addRepaintBoundaries,
            addSemanticIndexes: addSemanticIndexes,
          ),
        );

  /// fills the whole space and allows to layout a single widget as if it wouldn't be in a list.
  AdaptiveRefreshIndicator.fill({
    Key? key,
    EdgeInsets? padding,
    bool? adoptPhysics,
    ScrollPhysics? physics,
    RefreshCallback? onRefresh,
    bool? hasScrollBody,
    bool? fillOverscroll,
    RefreshIndicatorConfiguration? indicatorConfig,
    CupertinoSliverRefreshControlConfiguration? cupertinoConfig,
    CustomScrollViewConfiguration? config,
    bool? useMaterialIndicator,
    required Widget child,
  }) : this(
          key: key,
          padding: padding,
          physics: physics,
          onRefresh: onRefresh,
          indicatorConfig: indicatorConfig,
          cupertinoConfig: cupertinoConfig,
          config: config,
          useMaterialIndicator: useMaterialIndicator,
          adaptPhysics: adoptPhysics,
          sliver: SliverFillRemaining(
            hasScrollBody: hasScrollBody ?? true,
            fillOverscroll: fillOverscroll ?? false,
            child: child,
          ),
        );

  @override
  Widget build(BuildContext context) {
    TargetPlatform platform = Theme.of(context).platform;
    bool useMaterial = useMaterialIndicator ?? platform != TargetPlatform.iOS && platform != TargetPlatform.macOS;

    return RefreshIndicator(
      displacement: indicatorConfig.displacement,
      edgeOffset: indicatorConfig.edgeOffset,
      color: indicatorConfig.color,
      backgroundColor: indicatorConfig.backgroundColor,
      semanticsLabel: indicatorConfig.semanticsLabel,
      semanticsValue: indicatorConfig.semanticsValue,
      strokeWidth: indicatorConfig.strokeWidth,
      triggerMode: indicatorConfig.triggerMode,
      onRefresh: onRefresh,
      notificationPredicate: (n) => _enabled && useMaterial && n.depth == 0,
      child: CustomScrollView(
        physics: physics,
        controller: config.controller,
        primary: config.primary,
        clipBehavior: config.clipBehavior,
        shrinkWrap: config.shrinkWrap,
        anchor: config.anchor,
        cacheExtent: config.cacheExtent,
        center: config.center,
        dragStartBehavior: config.dragStartBehavior,
        hitTestBehavior: config.hitTestBehavior,
        keyboardDismissBehavior: config.keyboardDismissBehavior,
        restorationId: config.restorationId,
        reverse: config.reverse,
        scrollBehavior: config.scrollBehavior,
        scrollDirection: config.scrollDirection,
        semanticChildCount: config.semanticChildCount,
        slivers: [
          SliverVisibility(
            visible: _enabled && !useMaterial,
            sliver: SliverPadding(
              padding: padding,
              sliver: CupertinoSliverRefreshControl(
                refreshTriggerPullDistance: cupertinoConfig.refreshTriggerPullDistance,
                refreshIndicatorExtent: cupertinoConfig.refreshIndicatorExtent,
                builder: cupertinoConfig.builder,
                onRefresh: onRefresh,
              ),
            ),
          ),
          ...List.generate(slivers.length, (index) {
            return SliverPadding(
              padding: padding,
              sliver: slivers[index],
            );
          })
        ],
      ),
    );
  }

  static Future<void> _emptyRefreshCallback() => Future.value();

  static ScrollPhysics? _getAdoptedPhysics(bool? useMaterial) => switch (useMaterial) {
        (null) => null,
        (true) => const ClampingScrollPhysics(),
        (false) => const BouncingScrollPhysics(),
      };
}
