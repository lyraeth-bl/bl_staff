import 'dart:convert';

import 'package:bl_staff/core/api/failure/failure.dart';
import 'package:bl_staff/utils/shared/types/types.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

part 'api_constant.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<ApiResult> get(String url, {Map<String, dynamic>? queryParameters}) =>
      _execute(() => _dio.get(url, queryParameters: queryParameters));

  Future<ApiResult> post(
    String url, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
  }) => _execute(
    () => _dio.post(url, data: data, queryParameters: queryParameters),
  );

  Future<ApiResult> put(String url, {required Map<String, dynamic> data}) =>
      _execute(() => _dio.put(url, data: data));

  Future<ApiResult> delete(String url, {Map<String, dynamic>? data}) =>
      _execute(() => _dio.delete(url, data: data));

  Future<ApiResult> _execute(Future<Response> Function() call) async {
    try {
      final response = await call();
      return _parseResponse(response.data);
    } catch (e, st) {
      return left(Failure.fromDio(e, st));
    }
  }

  Either<Failure, Map<String, dynamic>> _parseResponse(dynamic data) {
    if (data is Map<String, dynamic>) return right(data);
    if (data is String) return _decodeJson(data);
    return left(
      Failure.unexpected(message: 'Unexpected response type.', cause: data),
    );
  }

  Either<Failure, Map<String, dynamic>> _decodeJson(String raw) {
    try {
      final decoded = json.decode(raw);
      if (decoded is Map<String, dynamic>) return right(decoded);
      return left(Failure.unexpected(cause: decoded));
    } catch (e, st) {
      return left(
        Failure.unexpected(
          message: 'Failed to parse JSON.',
          cause: e,
          stackTrace: st,
        ),
      );
    }
  }
}
