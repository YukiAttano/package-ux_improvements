import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class EndlessListViewScreen extends StatefulWidget {
  const EndlessListViewScreen({super.key});

  @override
  State<EndlessListViewScreen> createState() => _EndlessListViewScreenState();
}

class _EndlessListViewScreenState extends State<EndlessListViewScreen> {
  int? _negStart;
  int? _posStart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Settings(
          posStart: _posStart,
          negStart: _negStart,
          onChangePos: _onChangePos,
          onChangeNeg: _onChangeNeg,
        ),
        const Divider(color: Colors.transparent),
        Expanded(
          child: EndlessListView.builder(
            positiveStart: _posStart,
            negativeStart: _negStart,
            itemBuilder: (context, index) {
              return Text("$index", textAlign: TextAlign.center);
            },
          ),
        ),
      ],
    );
  }

  void _onChangePos(int? number) => setState(() => _posStart = number);

  void _onChangeNeg(int? number) => setState(() => _negStart = number);
}

class _Settings extends StatelessWidget {

  final int? posStart;
  final int? negStart;
  final void Function(int? number)? onChangePos;
  final void Function(int? number)? onChangeNeg;

  const _Settings({super.key, this.posStart, this.negStart, this.onChangePos, this.onChangeNeg});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Expanded(
            child: _NumberField(
              label: "Positive Start",
              currentNumber: posStart,
              onChanged: onChangePos,
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: _NumberField(
              label: "Negative Start",
              currentNumber: negStart,
              onChanged: onChangeNeg,
            ),
          ),
        ],
      ),
    );
  }
}


class _NumberField extends StatefulWidget {
  final int? currentNumber;
  final void Function(int? number)? onChanged;
  final String? label;

  const _NumberField({super.key, this.currentNumber, this.onChanged, this.label});

  @override
  State<_NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<_NumberField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateTextField();
  }

  @override
  void didUpdateWidget(covariant _NumberField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.currentNumber != widget.currentNumber) {
      _updateTextField();
    }
  }

  void _updateTextField() {
    _controller.text = widget.currentNumber?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged != null ? _onChanged : null,
      decoration: InputDecoration(labelText: widget.label),
    );
  }

  void _onChanged(String value) {
    if (value.isEmpty && widget.currentNumber != null) {
      widget.onChanged!(null);
      return;
    }

    int? number = int.tryParse(value);

    if (number != null && widget.currentNumber != number) {
      widget.onChanged!(number);
    }
  }
}
