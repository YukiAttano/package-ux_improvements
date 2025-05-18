import 'package:flutter/material.dart';
import 'package:ux_improvements/ux_improvements.dart';

class OverflowTextScreen extends StatelessWidget {
  const OverflowTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Text("The OverflowText allows you to build a Text Widget based a line limit rather than a given size"),
          Text(
              "This example shows a widget that expands the text to its maximum. Click on the Expanded Text to let it shrink again"),
          const SizedBox(height: 20),
          _ExpandableText(
            text: _loremIpsum,
            maxLines: 4,
            maxLinesExpanded: null,
          ),
        ],
      ),
    );
  }
}

class _ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int? maxLines;
  final int? maxLinesExpanded;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const _ExpandableText({
    super.key,
    required this.text,
    this.style,
    this.maxLines,

    /// if you copy this code, consider setting a limit for [maxLinesExpanded].
    this.maxLinesExpanded,
    this.textAlign,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<_ExpandableText> {
  late int? _maxLines = widget.maxLines;

  bool get _isExpanded =>
      widget.maxLinesExpanded != null && (_maxLines == null || _maxLines! >= widget.maxLinesExpanded!);

  @override
  Widget build(BuildContext context) {
    return OverflowText(
      text: widget.text,
      maxLines: _maxLines,
      style: widget.style,
      textAlign: widget.textAlign,
      overflow: widget.overflow,
      builder: (hasOverflow) {
        return GestureDetector(
          onTap: _onShrink,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.text,
                style: widget.style,
                maxLines: _maxLines,
                textAlign: widget.textAlign,
                overflow: _maxLines == null ? null : widget.overflow,
              ),
              Visibility(
                visible: hasOverflow && !_isExpanded,
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: _onExpand,
                        child: const Text("Expand"),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: _onExpandGradually,
                        child: const Text("+2 lines"),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: !hasOverflow && widget.maxLines != null,
                child: const Text(
                  "Click on the text to shrink it",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onExpand() {
    setState(() => _maxLines = widget.maxLinesExpanded);
  }

  void _onExpandGradually() {
    if (_maxLines != null) setState(() => _maxLines = _maxLines! + 2);
  }

  void _onShrink() {
    setState(() => _maxLines = widget.maxLines);
  }
}

const String _loremIpsum = """
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.  
Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.  
Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.  
Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.  
Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis.   
At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, At accusam aliquyam diam diam dolore dolores duo eirmod eos erat, et nonumy sed tempor et et invidunt justo labore Stet clita ea et gubergren, kasd magna no rebum. sanctus sea sed takimata ut vero voluptua. est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam
""";
