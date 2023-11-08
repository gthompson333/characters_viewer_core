class NetworkResult<T> {
  NetworkResult._();
  factory NetworkResult.success(T value) = SuccessState<T>;
  factory NetworkResult.error(T msg) = ErrorState<T>;
}

class ErrorState<T> extends NetworkResult<T> {
  ErrorState(this.msg) : super._();
  final T msg;
}

class SuccessState<T> extends NetworkResult<T> {
  SuccessState(this.value) : super._();
  final T value;
}
