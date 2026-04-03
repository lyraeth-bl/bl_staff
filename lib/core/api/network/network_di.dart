import 'package:bl_staff/core/api/network/dio_factory.dart';
import 'package:bl_staff/utils/shared/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

void initNetworkDI({
  required String baseUrl,
  Future<String?> Function()? tokenProvider,
  Future<void> Function()? onUnauthorized,
}) async {
  final dio = DioFactory().buildDioClient(
    baseUrl: baseUrl,
    enablePrettyLogging: !kReleaseMode,
    extraInterceptors: [
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenProvider?.call();
          debugPrint("TOKEN USED: $token");

          if (token != null && token.isNotEmpty) {
            options.headers['Accept'] = "application/json";
            options.headers['Content-Type'] = "application/json";
            options.headers['Authorization'] = "Bearer $token";
          }

          handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            await onUnauthorized?.call();
          }

          handler.next(error);
        },
      ),
    ],
  );

  getIt.registerLazySingleton<Dio>(() => dio);
}
