import "package:flutter/material.dart";

/// Automatically trigger pagination calls if the list view is going to an end.
///
/// 1. (Trigger) Triggers [onLoadRequested] if the elements following the list consume less space than the list is able to show.
/// 2. (Reset) The user must scroll the visible size of the list multiplied with [resetMultiplier] away from the bottom of the list.
/// 3. (Fallback Trigger) If rule 1 can't trigger because the list is too small, a request is made if the user overscrolls the list.
/// 4. (Fallback Reset) If rule 2 can't trigger because the list is too small, the logic is reset if the user scrolls to the top of the list.
///
/// Does not supported bidirectional lists yet
class TriggerLoadListener extends StatefulWidget {
  static const double _defaultResetMultiplier = 1.5;

  final Widget child;
  final void Function()? onLoadRequested;

  /// A check that specifies whether a [ScrollNotification] should be
  /// handled by this widget.
  ///
  /// By default, checks whether `notification.depth == 0`.
  final ScrollNotificationPredicate? notificationPredicate;

  /// how far the user has to scroll away from the end of the list to allow another request.
  ///
  /// The default is x1.5 of the inner list size.
  ///
  /// If the user cannot scroll that far away from the end, the list would be considered exhausted and no new requests would be made.
  /// As a fallback for that, a reset is triggered if the user scrolls to the top of the list.
  final double resetMultiplier;

  const TriggerLoadListener({
    super.key,
    required this.child,
    this.onLoadRequested,
    ScrollNotificationPredicate? notificationPredicate,
    double? resetMultiplier,
  })  : notificationPredicate = notificationPredicate ?? _defaultNotificationPredicate,
        assert((resetMultiplier ?? _defaultResetMultiplier) > 1, "resetMultiplier must be greater than 1"),
        resetMultiplier = resetMultiplier ?? _defaultResetMultiplier;

  static bool _defaultNotificationPredicate(ScrollNotification n) => n.depth == 0;

  @override
  State<TriggerLoadListener> createState() => _TriggerLoadListenerState();
}

class _TriggerLoadListenerState extends State<TriggerLoadListener> {
  bool hasRequested = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: widget.onLoadRequested != null ? _onNotification : null,
      child: widget.child,
    );
  }

  /// uses algorithm explained in [_onUpdateNotification] to request loading.
  ///
  /// [_onOverscrollNotification] is a fallback if the list is fully visible and therefor not enough elements exist to trigger the [_onUpdateNotification]
  /// in this case, we request a load [TriggerLoadListener.onLoadRequested] that is only reset through [_onUpdateNotification].
  /// This means, that if the list is fully visible, even after loading more content, no [ScrollUpdateNotification] but only an [OverscrollNotification] is triggered and therefor no reset happens.
  bool _onNotification(ScrollNotification notification) {
    assert(widget.onLoadRequested != null, "onLoadRequest must not be null");

    if (widget.notificationPredicate?.call(notification) ?? true) {
      switch (notification) {
        case ScrollUpdateNotification():
          return _onUpdateNotification(notification);
        case OverscrollNotification():
          return _onOverscrollNotification(notification);
      }
    }

    return false;
  }

  /// triggers [TriggerLoadListener.onLoadRequested] if the elements behind the list consume less space than the list is able to show.
  ///
  /// (the following example uses same sized elements but in real we are calculating based on the lists viewport)
  /// Example:
  /// If the list has 10 Elements and can show 2 elements, onRequestLoad will be triggered if element 8 is fully visible.
  ///
  /// To trigger the next request, the user has to scroll to the element that is 1.5x away from the size of the list.
  /// If the list has 10 elements and 2 are visible at the same time, the user has to scroll to element 6.
  /// ```text
  ///   2 elements are visible * 1.5 = 3 elements must be scrolled back from the lists end.
  ///   The end of element 10 is the end of the list. 3 elements from there is element 7.
  ///   Element 7 must be visible to trigger the reset.
  ///
  ///   2 * 1.5 = 3
  ///   10 - 3 = 7
  /// ```
  ///
  /// As a fallback for too short lists, a reset is triggered if the user scrolls to the begin of the list
  bool _onUpdateNotification(ScrollUpdateNotification notification) {
    if (!hasRequested) {
      bool isNearEnd = notification.metrics.extentAfter < notification.metrics.extentInside;

      if (isNearEnd) {
        hasRequested = true;

        widget.onLoadRequested!();
      }
    } else {
      bool isFarFromEnd = notification.metrics.extentAfter > notification.metrics.extentInside * widget.resetMultiplier;
      bool hasReachedTop = notification.metrics.extentBefore <= 0;

      if (isFarFromEnd || hasReachedTop) {
        hasRequested = false;
      }
    }

    return false;
  }

  /// If no request were made (because the list has too few items to fill the viewport (extentAfter == 0))
  /// and the user scrolls to the end (either top or bottom (OverscrollNotification)), a request is triggered
  bool _onOverscrollNotification(OverscrollNotification notification) {
    if (!hasRequested && notification.metrics.extentAfter == 0) {
      hasRequested = true;

      widget.onLoadRequested?.call();
    }

    return false;
  }
}
