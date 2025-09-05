import "package:flutter/material.dart";

typedef SpanBuilderCallback = InlineSpan Function(RegExpMatch match);
typedef SpanNoMatchBuilderCallback = InlineSpan Function(String text);

/// Builds [spans] based on [text]
///
/// For example:
/// [text] contains hyper-links that would make sense to be highlighted and to be clickable.
///
/// ```dart
/// SpanBuilder(
///   text: "hey come and see my package on https://pub.dev/packages/ux_improvements",
///   regexes: [regexHttps],
///   spanBuilder: (match) => _buildUrl(
///     match.input.substring(match.start, match.end),
///   ),
/// ),
///
/// static InlineSpan _buildUrl(String link) {
///    return WidgetSpan(
///      alignment: PlaceholderAlignment.middle,
///      child: TextButton(
///        onPressed: () async => _launch(link),
///        child: Text(link),
///      ),
///    );
///  }
/// ```
///
/// The generated [spans] can be used in a [RichText] widget.
class SpanBuilder {
  final String text;

  final List<InlineSpan> _spans = [];
  List<InlineSpan> get spans => _spans;

  final List<RegExp> regexes;

  final SpanBuilderCallback spanBuilder;
  final SpanNoMatchBuilderCallback noMatchBuilder;

  SpanBuilder({
    required this.text,
    this.regexes = const [],
    SpanBuilderCallback? spanBuilder,
    SpanNoMatchBuilderCallback? noMatchBuilder,
  })  : spanBuilder = spanBuilder ?? _defaultSpanBuilder,
        noMatchBuilder = noMatchBuilder ?? _defaultNoMatchSpanBuilder {
    _init();
  }

  void _init() {
    List<RegExpMatch> matches = [];

    for (var regex in regexes) {
      matches.addAll(regex.allMatches(text));
    }
    matches.sort((a, b) => a.start.compareTo(b.start));

    if (matches.isEmpty) {
      _spans.add(TextSpan(text: text));
    } else {
      RegExpMatch match = matches.first;
      RegExpMatch? nextMatch;

      if (match.start > 0) {
        _spans.add(TextSpan(text: text.substring(0, match.start)));
      }

      int maxZaehler = matches.length;
      for (int zaehler = 0; zaehler < maxZaehler; zaehler++) {
        nextMatch = null;
        match = matches[zaehler];
        if (zaehler + 1 < maxZaehler) nextMatch = matches[zaehler + 1];

        _spans.add(spanBuilder(match));
        if (nextMatch != null && match.end < nextMatch.start) {
          _spans.add(noMatchBuilder(text.substring(match.end, nextMatch.start)));
        }
      }

      int maxLength = text.length;
      if (match.end < maxLength) {
        _spans.add(TextSpan(text: text.substring(match.end, maxLength)));
      }
    }
  }

  static TextSpan _defaultSpanBuilder(RegExpMatch match) =>
      TextSpan(text: match.input.substring(match.start, match.end));

  static TextSpan _defaultNoMatchSpanBuilder(String text) => TextSpan(text: text);
}
