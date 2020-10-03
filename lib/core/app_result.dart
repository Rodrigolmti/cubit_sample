import 'package:arch_sample/core/app_failures.dart';

class Result<R> {
  final Failure failure;
  final R data;

  const Result({
    this.failure,
    this.data,
  });

  void onResult(
    Function(R) onSuccess,
    Function(Failure) onFailure,
  ) {
    if (failure != null) {
      onFailure(failure);
      return;
    }
    onSuccess(data);
  }
}
