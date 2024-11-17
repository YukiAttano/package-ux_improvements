import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class SuperimposeBoxScreen extends StatelessWidget {
  const SuperimposeBoxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SuperimposeBox(
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
              overlay: Chip(
                clipBehavior: Clip.none,
                label: Text("Text"),
              ),
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
      ),
    );
  }
}

/// This Widget shows, that the Stack blocks hits outside of itself
class _StackHitExample extends StatelessWidget {
  const _StackHitExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card(
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
          Positioned(
            right: -20,
            bottom: -20,
            child: ActionChip(
              label: Text("Hit me"),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
