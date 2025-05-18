import 'package:example/shared/widgets/number_field.dart';
import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class EndlessListViewScreen
    extends StatefulWidget {
  const EndlessListViewScreen(
      {super.key});

  @override
  State<EndlessListViewScreen>
      createState() =>
          _EndlessListViewScreenState();
}

class _EndlessListViewScreenState
    extends State<
        EndlessListViewScreen> {
  int? _negStart;
  int? _posStart;

  @override
  Widget build(
      BuildContext
          context) {
    return Column(
      children: [
        _Settings(
          posStart:
              _posStart,
          negStart:
              _negStart,
          onChangePos:
              _onChangePos,
          onChangeNeg:
              _onChangeNeg,
        ),
        const Divider(
            color: Colors
                .transparent),
        Expanded(
          child: EndlessListView
              .builder(
            positiveStart:
                _posStart,
            negativeStart:
                _negStart,
            itemBuilder:
                (context,
                    index) {
              return Text(
                  "$index",
                  textAlign: TextAlign.center);
            },
          ),
        ),
      ],
    );
  }

  void _onChangePos(
          int?
              number) =>
      setState(() =>
          _posStart =
              number);

  void _onChangeNeg(
          int?
              number) =>
      setState(() =>
          _negStart =
              number);
}

class _Settings
    extends StatelessWidget {
  final int?
      posStart;
  final int?
      negStart;
  final void Function(
          int?
              number)?
      onChangePos;
  final void Function(
          int?
              number)?
      onChangeNeg;

  const _Settings(
      {super.key,
      this.posStart,
      this.negStart,
      this.onChangePos,
      this.onChangeNeg});

  @override
  Widget build(
      BuildContext
          context) {
    return Material(
      child: Row(
        children: [
          Expanded(
            child:
                NumberField(
              label:
                  "Positive Start",
              currentNumber:
                  posStart,
              onChanged:
                  onChangePos,
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child:
                NumberField(
              label:
                  "Negative Start",
              currentNumber:
                  negStart,
              onChanged:
                  onChangeNeg,
            ),
          ),
        ],
      ),
    );
  }
}
