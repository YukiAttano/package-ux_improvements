import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class WarnBeforeUnloadScreen extends StatelessWidget {
  const WarnBeforeUnloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WarnBeforeUnload(
      child: Material(
        child: Column(
          children: [
            Text(
                "Reload the page, it will warn you before reloading (Web only).\nAs per documentation, the text and the box are not configurable."),
            SelectableText(
                "https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeunload_event"),
            const SizedBox(height: 20),
            Text(
                "The widget can be placed anywhere in the tree and will warn the user as long as it is mounted."),
            Text(
                "This feature requires to overwrite a top level function (/a global function) in javascript, multiple instances will overwrite each other."),
            Text(""),
          ],
        ),
      ),
    );
  }
}
