import 'package:flutter/widgets.dart';

class SmoothFutureBuilder<T> extends FutureBuilder<T> {
  SmoothFutureBuilder({super.key, super.initialData, required super.builder, required Future<T> future, Duration delay = const Duration(milliseconds: 300)})
      : super(
          future: Future.wait([future, Future.delayed(delay)], eagerError: true).then((value) => value.first),
        );
}
