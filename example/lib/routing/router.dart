import 'package:example/features/endless_list_view/endless_list_view_screen.dart';
import 'package:example/features/preloaded_image/preloaded_image_screen.dart';
import 'package:example/features/screenshot/screenshot_screen.dart';
import 'package:example/features/shimmer/shimmer_screen.dart';
import 'package:example/routing/widgets/menu_screen.dart';
import 'package:example/routing/widgets/nav_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

NavTarget initTarget = NavTarget.MENU;

final router = Provider(
  (ref) {
    return GoRouter(
      initialLocation: initTarget.route,
      redirect: (context, state) {
        if (state.uri.toString().isEmpty || state.uri.toString() == "/") {
          return initTarget.route;
        }
      },
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            return NavShell(state: state, child: child);
          },
          routes: [
            GoRoute(
              path: NavTarget.MENU.route,
              builder: (context, state) {
                return const MenuScreen();
              },
            ),
            GoRoute(
              path: NavTarget.ENDLESS_LIST_VIEW.route,
              builder: (context, state) {
                return const EndlessListViewScreen();
              },
            ),
            GoRoute(
              path: NavTarget.SCREENSHOT.route,
              builder: (context, state) {
                return const ScreenshotScreen();
              },
            ),
            GoRoute(
              path: NavTarget.SHIMMER.route,
              builder: (context, state) {
                return const ShimmerScreen();
              },
            ),
            GoRoute(
              path: NavTarget.PRELOADED_IMAGE.route,
              builder: (context, state) {
                return const PreloadedImageScreen();
              },
            ),
          ],
        ),
      ],
    );
  },
);

enum NavTarget {
  MENU("/menu", "Menu", ""),
  ENDLESS_LIST_VIEW("/endless_list_view", "EndlessListView",
      "Change the positive/negative start values to see how the list behaves."),
  SCREENSHOT("/screenshot", "ScreenshotBoundary",
      "You can configure the pixelRatio to increase the sharpness\n(This example only shows integer values, but doubles would also work)"),
  SHIMMER("/shimmer", "Shimmer", "Experiment with the values to achieve the effects you need"),
  PRELOADED_IMAGE("/preloaded_image", "PrelaodedImage", "The PreloadedImage allows to show a loading Widget and size the ink splash animation to its size, compared to a normal Image"),
  ;

  const NavTarget(this.route, this.title, this.description);

  final String route;
  final String title;
  final String description;

  static NavTarget fromRoute(String route) {
    for (var r in values) {
      if (r.route == route) {
        return r;
      }
    }

    return MENU;
  }

  Future<void> navigate(BuildContext context) {
    return GoRouter.of(context).push(route);
  }
}
