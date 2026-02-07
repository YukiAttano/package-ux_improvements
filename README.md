<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

This package bundles small Widgets that are generally useful in different Projects.

Bloating this package with a ton of Widgets is not the goal of this package.

All Widgets in this library are either considered useful (if not mandatory) to be used in any project 
or allow advantages that are otherwise tedious to re-implement.

## Intro

I recommend to take a look at the [Example project](https://uximprovements.memeozer.com/) to see the most (if not all) features in action.
(SpanBuilder example coming with next releases)
(ChainedTextScaler and AdaptiveTextScale example coming with next releases)

## Features

- FakeloadingWidget (introduce a min delay for non-async operations in the UI)
- SmoothFutureBuilder (introduce a min delay for async operations in the UI)
- Shimmer (a synchronized Shimmer effect above multiple widgets)
- ScreenshotBoundary (take screenshots without using the [screenshot](https://pub.dev/packages/screenshot) package)
- PreloadedImage (Ink splashes and decorations clipped to a not-yet loaded Image)
- ImplicitAnimatedIcon (use AnimatedIcons without dealing with the AnimationController)
- AdaptiveRefreshIndicator (feels more native then RefreshIndicator.adaptive)
- SuperimposeBox (similar to Flutters Badge but allows aligning widgets easier together)
- UnboundStack (like Stack, but allows hit-testing (e.g. clicking, hovering, ...) Widgets outside of its bounds)
- EndlessListView (builds Widgets in both directions)
- TriggerLoadListener (triggers pagination callbacks for lists)
- GlassCard / GlassContainer (Glassmorphism effect)
- WarnBeforeUnload (WebOnly - Warns the user before unloading or refreshing the page takes effect)
- OverflowText (Overflow aware text, allows to shrink text widgets that can expand to show more text)
- SpanBuilder (Replace String parts through regexes with custom widgets)
- ChainedTextScaler (Chains two text scaler together)
- AdaptiveTextScale (Overrides MediaQueries text scaler and optionally adopts the source scaler from an ancestor ChainedTextScaler)
- Cloak (Occupies the size of its child while preventing Hero animations and pointer interactions)
- BuildContext.textHeight() extension (returns the text height that would be applied at the current location in the widget tree)
- Re-Exports [responsive_ux](https://pub.dev/packages/responsive_ux)

(responsive_ux won't be re-exported in release 1.0.0, consider adding it explicitly)

## Getting started

```terminal
dart pub add ux_improvements
```

## Example Images

SuperimposeBox:
![SuperimposeBox.png](example/assets/SuperimposeBox.png)

Glassmorphism:
![Glassmorphism.png](example/assets/Glassmorphism.png)

AdaptiveRefreshIndicator:
![AdaptiveRefreshIndicator.gif](example/assets/AdaptiveRefreshIndicator.gif)
## Usage

If the documentation lacks some points, open an issue and i will improve it.

## Additional information

I am open for contributions and ideas to improve (but not bloat) this package. Feel free to reach out.

This package is under active development.