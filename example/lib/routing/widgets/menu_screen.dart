import 'package:example/routing/router.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _MenuEntry(target: NavTarget.ENDLESS_LIST_VIEW),
        _MenuEntry(target: NavTarget.SCREENSHOT),
        _MenuEntry(target: NavTarget.SHIMMER),
        _MenuEntry(target: NavTarget.PRELOADED_IMAGE),
      ],
    );
  }
}

class _MenuEntry extends StatelessWidget {
  final NavTarget target;

  const _MenuEntry({super.key, required this.target});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _goto(context),
      child: Text(target.title),
    );
  }

  void _goto(BuildContext context) {
    target.navigate(context);
  }
}
