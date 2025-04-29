## 0.12.1

### Added ###

* WarnBeforeUnload to warn a user before unloading (or refreshing) the website 
* OverflowText to build text widgets that can expand and shrink in lines

## 0.12.0

### Changed ###

* Changed Fakeloading.stack to use a builder for its replacement

## 0.11.9

### Added ###

* Add Fakeloading.builder for full control over this feature

## 0.11.8

### Added ###

* Add AdaptiveRefreshIndicator.custom for full control over this feature

## 0.11.7

### Added ###

* Add more parameter to GlassCardStyle
* Add more parameter to GlassContainerStyle

### Fixed ###

* Fixed using 'color' parameter in GlassCardStyle.defaultBorder()
* Fixed using 'opacity' parameter in GlassCardStyle.defaultBorder()

### Changed ###

* Changed example project link

## 0.11.6

### Docs ###

* Add multiple inline docs
* Add [Example](https://uximprovements.memeozer.com/) Website to showcase most of the features

## 0.11.5

### Added ###

* Add UnboundStack (like Stack, but allows hit-testing (e.g. clicking, hovering, ...) Widgets outside of its bounds)
* Add RenderUnboundStack (the RenderObject which enabled all the features of UnboundStack)
* Add AdaptiveRefreshIndicator.slivers (allows to use multiple slivers)
* Add GlassCard (Glassmorphism effect Widget with Cards)
* Add GlassContainer (Glassmorphism effect Widget as a general basis for other Widgets)
* Add Example project to improve the overall documentation

### Changed ###

* SuperimposeBox'd overlays are now clickable

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

