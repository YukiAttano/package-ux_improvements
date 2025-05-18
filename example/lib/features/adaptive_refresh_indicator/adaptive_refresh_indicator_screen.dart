import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class AdaptiveRefreshIndicatorScreen
    extends StatefulWidget {
  const AdaptiveRefreshIndicatorScreen(
      {super.key});

  @override
  State<AdaptiveRefreshIndicatorScreen>
      createState() =>
          _AdaptiveRefreshIndicatorScreenState();
}

class _AdaptiveRefreshIndicatorScreenState
    extends State<
        AdaptiveRefreshIndicatorScreen> {
  bool?
      _useMaterial;

  @override
  Widget build(
      BuildContext
          context) {
    return Column(
      children: [
        _Settings(
          selected:
              _useMaterial,
          onChangeIndicator:
              _changeIndicator,
        ),
        Text(
            "Swipe down"),
        Expanded(
          child: AdaptiveRefreshIndicator
              .builder(
            useMaterialIndicator:
                _useMaterial,
            onRefresh:
                _refresh,
            itemBuilder:
                (context,
                    index) {
              return Text(
                  index.toString(),
                  textAlign: TextAlign.center);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _refresh() async =>
      Future.delayed(
          const Duration(
              seconds:
                  2));

  void _changeIndicator(
      bool? value) {
    setState(() =>
        _useMaterial =
            value);
  }
}

class _Settings
    extends StatelessWidget {
  final bool?
      selected;
  final void Function(
          bool?
              value)
      onChangeIndicator;

  const _Settings(
      {super.key,
      this.selected,
      required this.onChangeIndicator});

  @override
  Widget build(
      BuildContext
          context) {
    const ButtonStyle
        unselectedStyle =
        ButtonStyle(
            elevation:
                WidgetStatePropertyAll(4));

    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceEvenly,
      children: [
        FilledButton
            .tonal(
          style: selected ==
                  null
              ? unselectedStyle
              : null,
          onPressed:
              () =>
                  onChangeIndicator(null),
          child: Text(
              "Platform Default"),
        ),
        FilledButton
            .tonal(
          style: selected ==
                  true
              ? unselectedStyle
              : null,
          onPressed:
              () =>
                  onChangeIndicator(true),
          child: Text(
              "Android"),
        ),
        FilledButton
            .tonal(
          style: selected ==
                  false
              ? unselectedStyle
              : null,
          onPressed:
              () =>
                  onChangeIndicator(false),
          child: Text(
              "Apple"),
        ),
      ],
    );
  }
}
