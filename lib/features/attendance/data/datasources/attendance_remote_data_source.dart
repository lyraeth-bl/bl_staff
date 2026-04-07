import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';
import '../../../../utils/utils_export.dart';
import '../models/monthly_attendance_response/monthly_attendance_response.dart';
import '../models/today_attendance_response/today_attendance_response.dart';

abstract class AttendanceRemoteDataSource {
  Future<Result<MonthlyAttendanceResponse>> fetchMonthlyAttendance({
    required int month,
    required int year,
  });

  Future<Result<TodayAttendanceResponse>> fetchTodayAttendance();
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  AttendanceRemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<Result<MonthlyAttendanceResponse>> fetchMonthlyAttendance({
    required int month,
    required int year,
  }) async {
    final Map<String, int> queryParameters = {'month': month, 'year': year};

    try {
      final response = await _apiClient.get(
        ApiPath.monthlyAttendance,
        queryParameters: queryParameters,
      );

      return response.match(
        (failure) => left(failure),
        (responseJson) =>
            right(MonthlyAttendanceResponse.fromJson(responseJson)),
      );
    } catch (e, st) {
      return left(Failure.fromDio(e, st));
    }
  }

  @override
  Future<Result<TodayAttendanceResponse>> fetchTodayAttendance() async {
    try {
      final response = await _apiClient.get(ApiPath.todayAttendance);

      return response.match(
        (failure) => left(failure),
        (responseJson) => right(TodayAttendanceResponse.fromJson(responseJson)),
      );
    } catch (e, st) {
      return left(Failure.fromDio(e, st));
    }
  }
}
