import 'package:freezed_annotation/freezed_annotation.dart';

import '../attendance_model/attendance_model.dart';

part 'monthly_attendance_response.freezed.dart';
part 'monthly_attendance_response.g.dart';

@freezed
abstract class MonthlyAttendanceResponse with _$MonthlyAttendanceResponse {
  const factory MonthlyAttendanceResponse({
    required bool error,
    required String message,
    @JsonKey(name: 'data') required List<AttendanceModel> listAttendanceModel,
  }) = _MonthlyAttendanceResponse;

  factory MonthlyAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$MonthlyAttendanceResponseFromJson(json);
}
