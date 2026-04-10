import 'package:freezed_annotation/freezed_annotation.dart';

import '../attendance_model/attendance_model.dart';

part 'monthly_attendance_response.freezed.dart';
part 'monthly_attendance_response.g.dart';

/// A response object for the monthly attendance API endpoint.
///
/// This model encapsulates the raw API response, including the status,
/// message, and a list of attendance records for the requested period.
///
/// See also:
/// * [AttendanceModel], the data model for individual attendance records.
@freezed
abstract class MonthlyAttendanceResponse with _$MonthlyAttendanceResponse {
  /// Creates a [MonthlyAttendanceResponse] with the given response data.
  const factory MonthlyAttendanceResponse({
    /// Whether the request encountered an error.
    required bool error,

    /// The message returned by the API, often used for error descriptions.
    required String message,

    /// The list of attendance records for the month.
    @JsonKey(name: 'data') required List<AttendanceModel> listAttendanceModel,
  }) = _MonthlyAttendanceResponse;

  /// Creates a [MonthlyAttendanceResponse] from a JSON map.
  ///
  /// Returns a [MonthlyAttendanceResponse] instance populated with the data
  /// from [json].
  factory MonthlyAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$MonthlyAttendanceResponseFromJson(json);
}
