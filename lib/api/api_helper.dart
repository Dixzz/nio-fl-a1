import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_helper.freezed.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success(T data) = _Success<T>;
  const factory ApiResult.loading() = _Loading<T>;
  const factory ApiResult.error(String error) = _Error<T>;
}

