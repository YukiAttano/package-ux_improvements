
import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: FlutterLogo()),
        Card(
          color: Colors.transparent,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),

          ),
          elevation: 0,
          child: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: ColoredBox(
                    color: Colors.green.withOpacity(0.1),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:  Colors.white.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                ),
                child: Column(
                  children: [
                    Text("       Text      "),
                    Text(""),
                    Text(""),
                    Text(""),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
