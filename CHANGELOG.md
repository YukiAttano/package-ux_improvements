## 0.11.4

### Fixed ###

* Fix AdaptiveRefreshIndicator.widgets to no more handling its children as slivers 

## 0.11.3

### Added ###

* Add SuperimposeBox which is similar to Badge but allows to align the overlay according to its child.
* Add EndlessListView which builds Widgets in both directions

## 0.11.2

### Added ###

* Add AdaptiveRefreshIndicator.widgets

## 0.11.1

### Added ###

* Add AdaptiveRefreshIndicator (feels more native then RefreshIndicator.adaptive)

## 0.11.0

### Changed ###

* Fixed updating PreloadedImage after it got disposed
**Breaking:** updated to responsive_ux 0.3.0

## 0.10.1

### Changed ###

* Add optional Duration value to ShimmerArea and ShimmerBox


## 0.10.0

### Changed ###

**Breaking:** updated to responsive_ux 0.2.0

## 0.9.0

* Add FakeloadingWidget (introduces a delay for non-async operations in the UI)
* Add SmoothloadingFuture (introduces a delay for async operations in the UI)
* Add ScreenshotBoundary (for taking screenshots)
* Add Shimmer / ShimmerArea / ShimmerBox (Shimmer effect)
* Add PreloadedImage (allows Ink splashes and BoxDecoration clipped to an not-yet loaded image)
* Add ImplicitAnimatedIcon (AnimatedIcon without the need to handle the AnimationController)
* Re-exports responsive_ux

