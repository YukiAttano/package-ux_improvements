import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class PreloadedImageScreen extends StatelessWidget {
  const PreloadedImageScreen({super.key});

  static const String _flutterLogoUrl =
      "https://lh3.googleusercontent.com/5_Jv6g9l2OSa_xKX89kk1TcIfRjvl4jAepvQ3V6yf0A81TZLGWeGMe3vaj0bVMNzssvZQ2Iehq0YEjPgg2XkpsoYjIJerQ65CHzPWiU";

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Flexible(
            child: InkWell(
              onTap: () {
                _showExplanation(context,
                    "Ink animation is over the image, but it is NOT clipped to the image size");
              },
              child: Ink.image(
                image: const NetworkImage(_flutterLogoUrl),
              ),
            ),
          ),
          Flexible(
            child: PreloadedImage(
              borderRadius: BorderRadius.circular(12),
              onPressed: () {
                _showExplanation(context,
                    "Ink animation is over the image, and it IS clipped to the image size");
              },
              image: const DecorationImage(
                image: NetworkImage(_flutterLogoUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExplanation(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
