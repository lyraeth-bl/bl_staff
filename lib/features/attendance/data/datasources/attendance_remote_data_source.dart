import 'package:fpdart/fpdart.dart';

import '../../../../core/core.dart';
import '../../../../utils/utils_export.dart';
import '../models/monthly_attendance_response/monthly_attendance_response.dart';
import '../models/today_attendance_response/today_attendance_response.dart';

/// A data source for fetching attendance data from a remote server.
///
/// This interface defines methods for communicating with the API to retrieve
/// monthly and daily attendance records.
///
/// See also:
/// * [AttendanceRemoteDataSourceImpl], for the concrete implementation.
abstract class AttendanceRemoteDataSource {
  /// Returns a [Result] containing the [MonthlyAttendanceResponse] for the
  /// given [month] and [year].
  Future<Result<MonthlyAttendanceResponse>> fetchMonthlyAttendance({
    required int month,
    required int year,
  });

  /// Returns a [Result] containing the [TodayAttendanceResponse] for the
  /// current day.
  Future<Result<TodayAttendanceResponse>> fetchTodayAttendance();
}

/// An implementation of [AttendanceRemoteDataSource] that uses an [ApiClient]
/// for network requests.
///
/// This class handles the construction of query parameters, endpoint
/// selection, and error handling for remote attendance operations. It maps
/// raw responses into response models.
class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  /// Creates an [AttendanceRemoteDataSourceImpl] with the given [ApiClient].
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
