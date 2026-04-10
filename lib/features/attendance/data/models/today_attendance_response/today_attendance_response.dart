import 'package:freezed_annotation/freezed_annotation.dart';

import '../attendance_model/attendance_model.dart';

part 'today_attendance_response.freezed.dart';
part 'today_attendance_response.g.dart';

/// A response object for the today's attendance API endpoint.
///
/// This model encapsulates the raw API response, including the status,
/// message, and the actual attendance record if it exists.
///
/// See also:
/// * [AttendanceModel], the nested data model for the attendance record.
@freezed
abstract class TodayAttendanceResponse with _$TodayAttendanceResponse {
  /// Creates a [TodayAttendanceResponse] with the given response data.
  const factory TodayAttendanceResponse({
    /// Whether the request encountered an error.
    required bool error,

    /// The message returned by the API, often used for error descriptions.
    required String message,

    /// The attendance record for today, if available.
    @JsonKey(name: 'data') AttendanceModel? attendanceModel,
  }) = _TodayAttendanceResponse;

  /// Creates a [TodayAttendanceResponse] from a JSON map.
  ///
  /// Returns a [TodayAttendanceResponse] instance populated with the data
  /// from [json].
  factory TodayAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$TodayAttendanceResponseFromJson(json);
}
