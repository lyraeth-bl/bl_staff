import 'package:freezed_annotation/freezed_annotation.dart';

import '../attendance_model/attendance_model.dart';

part 'today_attendance_response.freezed.dart';
part 'today_attendance_response.g.dart';

@freezed
abstract class TodayAttendanceResponse with _$TodayAttendanceResponse {
  const factory TodayAttendanceResponse({
    required bool error,
    required String message,
    @JsonKey(name: 'data') AttendanceModel? attendanceModel,
  }) = _TodayAttendanceResponse;

  factory TodayAttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$TodayAttendanceResponseFromJson(json);
}
