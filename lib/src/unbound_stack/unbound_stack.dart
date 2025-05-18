import "package:flutter/foundation.dart";
import "package:flutter/widgets.dart";
import "unbound_render_stack.dart";

/// The same as [Stack] but will allow to hit widgets outside of its own bounds
class UnboundStack extends Stack {
  /// if true (the default) will allow to hit widgets that are out of the stack bounds
  ///
  /// if false, will act the same as [Stack]
  final bool hitTestIgnoreBound;

  const UnboundStack({
    super.key,
    super.alignment,
    super.textDirection,
    super.fit,
    super.clipBehavior,
    super.children,
    this.hitTestIgnoreBound = true,
  });

  @override
  UnboundRenderStack createRenderObject(BuildContext context) {
    // ignore: prefer_asserts_with_message as message is given in the called function
    assert(_debugCheckHasDirectionality(context));
    return UnboundRenderStack(
      alignment: alignment,
      textDirection: textDirection ?? Directionality.maybeOf(context),
      fit: fit,
      clipBehavior: clipBehavior,
      hitTestIgnoreBound: hitTestIgnoreBound,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    UnboundRenderStack renderObject,
  ) {
    super.updateRenderObject(context, renderObject);
    renderObject.hitTestIgnoreBound = hitTestIgnoreBound;
  }

  bool _debugCheckHasDirectionality(BuildContext context) {
    if (alignment is AlignmentDirectional && textDirection == null) {
      assert(
        debugCheckHasDirectionality(
          context,
          why: "to resolve the 'alignment' argument",
          hint: alignment == AlignmentDirectional.topStart
              ? "The default value for 'alignment' is AlignmentDirectional.topStart, which requires a text direction."
              : null,
          alternative:
              "Instead of providing a Directionality widget, another solution would be passing a non-directional 'alignment', or an explicit 'textDirection', to the $runtimeType.",
        ),
        "",
      );
    }
    return true;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<bool>("hitTestIgnoreBound", hitTestIgnoreBound),
    );
  }
}
