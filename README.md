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
Thanks to Dart, bloating this package with a ton of Widgets wouldn't hurt anyone, but is still not the goal of this package.

## Intro

One of the features is the ScreenshotBoundary. It allows to easily take screenshots of widgets.
As this introduces a fast and easy screenshot functionality, it will never grow to the size of the [screenshot](https://pub.dev/packages/screenshot) package.
Instead, improvements like video capture will be laid out in a dedicated library and not bloat this package.

## Features

- FakeloadingWidget (introduce a min delay for non-async operations in the UI)
- SmoothFutureBuilder (introduce a min delay for async operations in the UI)
- Shimmer (a synchronized Shimmer effect above multiple widgets)
- ScreenshotBoundary (take screenshots without using the screenshot package)
- ImplicitAnimatedIcon (use AnimatedIcons without dealing with the AnimationController)
- PreloadedImage (Ink splashes and decorations clipped to not-yet loaded Image)
- AdaptiveRefreshIndicator (feels more native then RefreshIndicator.adaptive)
- SuperimposeBox (similar to Flutters Badge but allows aligning widgets easier together)
- Re-Exports [responsive_ux](https://pub.dev/packages/responsive_ux) 

## Getting started

```terminal
dart pub add ux_improvements
```

## Usage

As this package is mainly developed for my own use, there is no full usage documentation yet.
(But will definitely come in the future)

## Additional information

I am open for contributions and ideas to improve (but not bloat) this package. Feel free to reach out.

This package is under active development, does not await breaking changes (only if they are required to fix something that is really wrong).
and will be set to v 1.0 after examples and a usage documentation is added.
