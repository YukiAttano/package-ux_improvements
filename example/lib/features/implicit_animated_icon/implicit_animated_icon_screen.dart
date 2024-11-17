import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class ImplicitAnimatedIconScreen extends StatefulWidget {
  const ImplicitAnimatedIconScreen({super.key});

  @override
  State<ImplicitAnimatedIconScreen> createState() => _ImplicitAnimatedIconScreenState();
}

class _ImplicitAnimatedIconScreenState extends State<ImplicitAnimatedIconScreen> {
  bool _isStarted = false;

  Duration _duration = Duration(seconds: 2);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() => _isStarted = !_isStarted);
            },
            child: Text("Toggle"),
          ),
          ImplicitAnimatedIcon(
            icon: AnimatedIcons.pause_play,
            isStarted: _isStarted,
            duration: _duration,
            size: 100,
          ),
        ],
      ),
    );
  }
}
