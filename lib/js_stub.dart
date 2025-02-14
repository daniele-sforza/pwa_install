class JS {
  final String? name;
  const JS([this.name]);
}

// Stub for JSFunction type from dart:js_interop
class JSFunction {
  const JSFunction();
}

// Stub for toJS extension from dart:js_interop
extension JSFunctionExtension on Function {
  JSFunction get toJS => throw UnimplementedError();
}

allowInterop<F extends Function>(F f) {
  throw UnimplementedError();
}
