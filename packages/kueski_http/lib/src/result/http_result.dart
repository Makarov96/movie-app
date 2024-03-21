sealed class HttpResult<R> {
  const HttpResult();
  factory HttpResult.ok(R ok, int statusCode) =>
      Ok(ok: ok, statusCode: statusCode);
  factory HttpResult.err(int? statusCode, Object? error) =>
      Err(statusCode: statusCode, error: error);

  B fold<B>(B Function(int? statusCode, Object? error) l, B Function(R, int) r);
  B when<B>(B Function(int? statusCode, Object? error) l, B Function() loading,
      B Function(R) r) {
    return loading();
  }
}

class Ok<R> extends HttpResult<R> {
  const Ok({
    required this.ok,
    required this.statusCode,
  });
  final R ok;
  final int statusCode;

  @override
  B fold<B>(B Function(int? statusCode, Object? error) l,
      B Function(R p1, int statusCode) r) {
    return r(ok, statusCode);
  }

  @override
  B when<B>(B Function(int? statusCode, Object? error) l, B Function() loading,
      B Function(R p1) r) {
    loading();
    return r(ok);
  }
}

class Err<R> extends HttpResult<R> {
  const Err({
    required this.statusCode,
    required this.error,
  });

  final int? statusCode;
  final Object? error;

  @override
  B fold<B>(B Function(int? statusCode, Object? error) l,
      B Function(R p1, int statusCode) r) {
    return l(statusCode, error);
  }

  @override
  B when<B>(B Function(int? statusCode, Object? error) l, B Function() loading,
      B Function(R p1) r) {
    loading();
    return l(statusCode, error);
  }
}
