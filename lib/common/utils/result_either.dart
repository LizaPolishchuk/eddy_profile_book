//own alternative to Either from dartz package
import 'package:eddy_profile_book/domain/entities/failure.dart';

class Result<T extends Object> {
  final T? data;
  final Failure? error;

  bool get hasError => error != null;

  bool get hasData => data != null;

  const Result._(this.data, this.error);

  factory Result.success([T? data]) => Result._(data, null);

  factory Result.error(Failure error) => Result._(null, error);

  void fold({required Function(T?) onSuccess, required Function(Failure) onError}) {
    if (this.error != null) {
      onError.call(this.error!);
    } else {
      onSuccess(this.data);
    }
  }
}
