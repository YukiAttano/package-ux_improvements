import 'package:flutter/material.dart';

class NumberField extends StatefulWidget {
  final int? currentNumber;
  final void Function(int? number)? onChanged;
  final String? label;

  const NumberField(
      {super.key, this.currentNumber, this.onChanged, this.label});

  @override
  State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateTextField();
  }

  @override
  void didUpdateWidget(covariant NumberField oldWidget) {
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
