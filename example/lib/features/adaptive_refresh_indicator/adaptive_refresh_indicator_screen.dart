import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class AdaptiveRefreshIndicatorScreen extends StatefulWidget {
  const AdaptiveRefreshIndicatorScreen({super.key});

  @override
  State<AdaptiveRefreshIndicatorScreen> createState() => _AdaptiveRefreshIndicatorScreenState();
}

class _AdaptiveRefreshIndicatorScreenState extends State<AdaptiveRefreshIndicatorScreen> {
  bool? _useMaterial;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Settings(
          onChangeIndicator: _changeIndicator,
        ),
        Text("Swipe down"),
        Expanded(
          child: AdaptiveRefreshIndicator.builder(
            useMaterialIndicator: _useMaterial,
            onRefresh: _refresh,
            itemBuilder: (context, index) {
              return Text(index.toString(), textAlign: TextAlign.center);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _refresh() async => Future.delayed(const Duration(seconds: 2));

  void _changeIndicator(bool? value) {
    setState(() => _useMaterial = value);
  }
}

class _Settings extends StatelessWidget {
  final void Function(bool? value) onChangeIndicator;

  const _Settings({super.key, required this.onChangeIndicator});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FilledButton.tonal(
          onPressed: () => onChangeIndicator(null),
          child: Text("Platform Default"),
        ),
        FilledButton.tonal(
          onPressed: () => onChangeIndicator(true),
          child: Text("Android"),
        ),
        FilledButton.tonal(
          onPressed: () => onChangeIndicator(false),
          child: Text("Apple"),
        ),
      ],
    );
  }
}
