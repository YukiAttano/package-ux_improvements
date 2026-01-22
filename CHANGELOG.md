## 0.13.7

### Added ###

* actually export the BuildContext.textHeight() extension

## 0.13.6

### Added ###

* BuildContext extension .textHeight() to get the applied text height anywhere in the tree (useful to scale icons to the same size as texts in the same row)

### Changed ###

* lint rules changed to improved_analysis

## 0.13.5

### Added ###

* RawPreloadedImage and PreloadedImage now support errorBuilder and chunkBuilder callbacks

## 0.13.4

### Added ###

* TriggerLoadListener for automatically triggering pagination callbacks

## 0.13.3

### Added ###

* ChainedTextScaler for chaining two text scaler (for example to inherit the SystemTextScaler and additionally applying a linear text scale)
* AdaptiveTextScale for overriding text scales in the subtree with correctly applying an AdaptiveTextScaler

## 0.13.2

### Fixed ###

* Padding in AdaptiveRefreshIndicator now works like ListView.padding instead of wrapping every child

## 0.13.1

### Added ###

* SpanBuilder to split texts based on regexes and replace them with custom widgets

### Fixed ###

* OverflowText has calculated without TextScaler and correct TextStyle, if none were explicitly set

## 0.13.0

### Added ###

* Add RawPreloadedImage as bare bone for PreloadedImage to allow fine grained customization 

### Changed ###

* **Breaking:** updated to responsive_ux 1.0.1

### Removed ###

* **Breaking:** removed unused parameter from GlassContainerStyle.fallback()

## 0.12.2

### Added ###

* PreloadedImage now allows to place a child in front of it
* Example of WarnBeforeUnload
* Example of OverflowText

### Fixed ###

* PreloadedImage now reacts to image changes and rebuilds correctly

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
* **Breaking:** updated to responsive_ux 0.3.0

## 0.10.1

### Changed ###

* Add optional Duration value to ShimmerArea and ShimmerBox


## 0.10.0

### Changed ###

* **Breaking:** updated to responsive_ux 0.2.0

## 0.9.0

* Add FakeloadingWidget (introduces a delay for non-async operations in the UI)
* Add SmoothloadingFuture (introduces a delay for async operations in the UI)
* Add ScreenshotBoundary (for taking screenshots)
* Add Shimmer / ShimmerArea / ShimmerBox (Shimmer effect)
* Add PreloadedImage (allows Ink splashes and BoxDecoration clipped to an not-yet loaded image)
* Add ImplicitAnimatedIcon (AnimatedIcon without the need to handle the AnimationController)
* Re-exports responsive_ux

