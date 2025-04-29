import "dart:js_interop";

import "package:flutter/material.dart";
import "package:web/web.dart";

void _preventDefault(Event event) {
  event.returnValue = true;
  event.preventDefault();
}

/// see https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeunload_event
class WarnBeforeUnload extends StatefulWidget {
  final Widget child;
  final bool warn;

  /// see https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeunload_event
  ///
  /// - The dialog will only be displayed if the user interacted with the website after it was loaded.
  /// - The content of the dialog is not configurable.
  const WarnBeforeUnload({
    super.key,
    required this.child,
    this.warn = true,
  });

  @override
  State<WarnBeforeUnload> createState() => _WarnBeforeUnloadState();
}

class _WarnBeforeUnloadState extends State<WarnBeforeUnload> {
  OnBeforeUnloadEventHandler? _previousEventHandler;

  @override
  void initState() {
    super.initState();

    _update();
  }

  @override
  void didUpdateWidget(covariant WarnBeforeUnload oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.warn != widget.warn) {
      _update();
    }
  }

  void _update() {
    if (widget.warn) {
      _previousEventHandler = window.onbeforeunload;
      window.onbeforeunload = _preventDefault.toJS;
    } else {
      _reset();
    }
  }

  void _reset() {
    window.onbeforeunload = _previousEventHandler;
  }

  @override
  void dispose() {
    _reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
