import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";

/// Like [FakeloadingWidget], this [FutureBuilder] waits at least until [delay] is finished before returning
class SmoothFutureBuilder<T> extends FutureBuilder<T> {
  SmoothFutureBuilder({super.key, super.initialData, required super.builder, required Future<T> future, Duration delay = const Duration(milliseconds: 300)})
      : super(
          future: future is SynchronousFuture ? future : Future.wait([future, Future.delayed(delay)], eagerError: true).then((value) => value.first),
        );
}
