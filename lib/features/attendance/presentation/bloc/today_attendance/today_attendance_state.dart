part of 'today_attendance_cubit.dart';

@freezed
abstract class TodayAttendanceState with _$TodayAttendanceState {
  const factory TodayAttendanceState.initial() = _Initial;

  const factory TodayAttendanceState.loading() = _Loading;

  const factory TodayAttendanceState.success({
    required AttendanceEntity? attendance,
  }) = _Success;

  const factory TodayAttendanceState.failure(Failure failure) = _Failure;
}
