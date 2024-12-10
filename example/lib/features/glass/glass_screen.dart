import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class GlassScreen extends StatelessWidget {
  const GlassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FlutterLogo(
          size: 200,
        ),
        GlassCard(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text("Try different settings to see the effect"),
          ),
        ),
      ],
    );
  }
}
