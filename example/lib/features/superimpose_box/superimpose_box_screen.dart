import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class SuperimposeBoxScreen extends StatelessWidget {
  const SuperimposeBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SuperimposeBox(
        overlays: const [
          Superimpose(
            overlay: Chip(
              label: Text("Superimposed"),
            ),
          ),
          Superimpose(
            overlayAlign: Alignment.centerRight,
            childAlign: Alignment.bottomRight,
            overlay: ElevatedButton(onPressed: _empty, child: Text("Click me")),
          ),
        ],
        child: const Card(
          color: Colors.green,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(""),
                Text("Some Text on a Card"),
                Text(""),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void _empty() {}
}
