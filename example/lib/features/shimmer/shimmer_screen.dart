import 'dart:typed_data';

import 'package:example/shared/widgets/number_field.dart';
import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class ShimmerScreen extends StatefulWidget {
  const ShimmerScreen({super.key});

  @override
  State<ShimmerScreen> createState() => _ShimmerScreenState();
}

class _ShimmerScreenState extends State<ShimmerScreen> {
  static final LinearGradient _gradient = ShimmerArea.silverShimmerGradient.copyWithColors(
    // with an opacity of 1 (the default), the Widgets will be fully occupied by the Shader
    colors: ShimmerArea.sliverColors.copyWithOpacity(0.8),
  );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.secondaryContainer,
      // You can also use ShimmerArea.fromTheme to let it style according to ThemeStyles.
      body: ShimmerArea(
        gradient: _gradient,
        child: Column(
          children: [
            const Shimmer(child: _Cards()),
            const Shimmer(child: _Cards()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: DecoratedBox(
                  position: DecorationPosition.foreground,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: ClipRect(
                    child: Shimmer(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return const ListTile(
                            title: _Cards(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Shimmer(child: _Cards()),
            const Shimmer(child: _Cards()),
          ],
        ),
      ),
    );
  }
}

class _Cards extends StatelessWidget {
  const _Cards({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Card(
          color: Colors.red.shade200,
          child: SizedBox(width: 100, height: 50),
        ),
        Card(
          color: Colors.blue.shade200,
          child: SizedBox(width: 50, height: 50),
        ),
        Card(
          color: Colors.green.shade200,
          child: SizedBox(width: 50, height: 50),
        ),
        Card(
          color: Colors.yellow.shade200,
          child: SizedBox(width: 100, height: 50),
        ),
      ],
    );
  }
}

extension LinearGradientExtension on LinearGradient {
  LinearGradient copyWithColors({
    List<Color>? colors,
  }) {
    return LinearGradient(
      colors: colors ?? this.colors,
      end: end,
      begin: begin,
      stops: stops,
      tileMode: tileMode,
      transform: transform,
    );
  }
}

extension ColorListExtension on List<Color> {
  List<Color> copyWithOpacity(double opacity) {
    List<Color> colors = [];

    for (var c in this) {
      colors.add(c.withOpacity(opacity));
    }

    return colors;
  }
}
