//own alternative to Either from dartz package
import 'package:eddy_profile_book/domain/entities/failure.dart';

class Result<T extends Object> {
  final T? data;
  final Failure? error;

  bool get hasError => error != null;

  bool get hasData => data != null;

  const Result._(this.data, this.error);

  factory Result.data([T? data]) => Result._(data, null);

  factory Result.error(Failure error) => Result._(null, error);

  void fold({required Function(T) data, required Function(Failure) error}) {
    if (this.data != null) {
      data(this.data!);
    }
    if (this.error != null) {
      error.call(this.error!);
    }
  }
}
