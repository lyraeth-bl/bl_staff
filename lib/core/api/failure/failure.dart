import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  /// Error handling untuk masalah koneksi.
  /// no internet, timeout, dll.
  const factory Failure.network({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = NetworkFailure;

  /// Error handling untuk masalah authentikasi (401).
  const factory Failure.unauthorized({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = UnauthorizedFailure;

  /// Error handling untuk masalah Forbidden (403).
  const factory Failure.forbidden({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = ForbiddenFailure;

  /// 422 - Validation error (Laravel's default validation response)
  /// [message] = summary dari Laravel (e.g. "The email field is required. (and 2 more errors)")
  /// [errors] = per-field errors, e.g. {"email": ["The email field is required."]}
  const factory Failure.validation({
    String? message,
    @Default({}) Map<String, List<String>> errors,
    Object? cause,
    StackTrace? stackTrace,
  }) = ValidationFailure;

  /// Error handling untuk masalah pada server (500).
  const factory Failure.server({
    String? message,
    int? statusCode,
    Object? cause,
    StackTrace? stackTrace,
  }) = ServerFailure;

  /// Error handling ketika request di batalkan.
  const factory Failure.cancelled({Object? cause, StackTrace? stackTrace}) =
      CancelledFailure;

  /// Error handling ketika ada sesuatu yang tidak terduga.
  const factory Failure.unexpected({
    String? message,
    Object? cause,
    StackTrace? stackTrace,
  }) = UnexpectedFailure;

  String get displayMessage => map(
    network: (f) => f.message ?? 'Tidak dapat terhubung ke server.',
    unauthorized: (f) =>
        f.message ?? 'Sesi telah berakhir, silakan login kembali.',
    forbidden: (f) => f.message ?? 'Anda tidak memiliki akses.',
    validation: (f) => f.message ?? 'Data yang dikirim tidak valid.',
    server: (f) => f.message ?? 'Terjadi kesalahan pada server.',
    cancelled: (_) => 'Request dibatalkan.',
    unexpected: (f) => f.message ?? 'Terjadi kesalahan yang tidak terduga.',
  );

  static Failure fromDio(Object error, [StackTrace? stackTrace]) {
    if (error is DioException) {
      return switch (error.type) {
        DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout => Failure.network(
          message: 'Connection timed out.',
          cause: error,
          stackTrace: stackTrace ?? error.stackTrace,
        ),
        DioExceptionType.cancel => Failure.cancelled(
          cause: error,
          stackTrace: stackTrace ?? error.stackTrace,
        ),
        DioExceptionType.badResponse => _mapBadResponse(error, stackTrace),
        // connectionError, badCertificate, unknown
        _ => _mapNetworkOrUnknown(error, stackTrace),
      };
    }

    if (error is SocketException) {
      return Failure.network(cause: error, stackTrace: stackTrace);
    }

    if (error is FormatException || error is TypeError) {
      return Failure.unexpected(
        message: 'Failed to parse response.',
        cause: error,
        stackTrace: stackTrace,
      );
    }

    return Failure.unexpected(cause: error, stackTrace: stackTrace);
  }

  /// Helpers
  static Failure _mapBadResponse(DioException e, StackTrace? st) {
    final status = e.response?.statusCode;
    final data = e.response?.data;

    // Parse body kalau JSON
    String? message;
    Map<String, List<String>> fieldErrors = {};

    if (data is Map<String, dynamic>) {
      message = data['message'] as String?;

      // Parse Laravel field errors: {"email": ["msg1", "msg2"], ...}
      final raw = data['errors'];
      if (raw is Map<String, dynamic>) {
        fieldErrors = raw.map(
          (key, value) => MapEntry(
            key,
            value is List ? value.whereType<String>().toList() : <String>[],
          ),
        );
      }
    }

    return switch (status) {
      401 => Failure.unauthorized(
        message: message ?? 'Unauthenticated.',
        cause: e,
        stackTrace: st ?? e.stackTrace,
      ),
      403 => Failure.forbidden(
        message: message ?? 'Forbidden.',
        cause: e,
        stackTrace: st ?? e.stackTrace,
      ),
      422 => Failure.validation(
        message: message,
        errors: fieldErrors,
        cause: e,
        stackTrace: st ?? e.stackTrace,
      ),
      _ when status != null && status >= 500 => Failure.server(
        message: message ?? 'Internal server error.',
        statusCode: status,
        cause: e,
        stackTrace: st ?? e.stackTrace,
      ),
      _ => Failure.unexpected(
        message: message,
        cause: e,
        stackTrace: st ?? e.stackTrace,
      ),
    };
  }

  static Failure _mapNetworkOrUnknown(DioException e, StackTrace? st) {
    final underlying = e.error;
    if (underlying is SocketException ||
        underlying is HandshakeException ||
        underlying is TlsException) {
      return Failure.network(cause: e, stackTrace: st ?? e.stackTrace);
    }
    return Failure.unexpected(cause: e, stackTrace: st ?? e.stackTrace);
  }
}
