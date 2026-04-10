part of 'today_attendance_cubit.dart';

/// The various states of the [TodayAttendanceCubit].
@freezed
abstract class TodayAttendanceState with _$TodayAttendanceState {
  /// The initial state before any data has been requested.
  const factory TodayAttendanceState.initial() = _Initial;

  /// The state when today's attendance record is being fetched.
  const factory TodayAttendanceState.loading() = _Loading;

  /// The state when today's attendance record has been successfully retrieved.
  const factory TodayAttendanceState.success({
    /// The attendance record for today, or null if not yet clocked in.
    required AttendanceEntity? attendance,
  }) = _Success;

  /// The state when no attendance record exists for the current day.
  const factory TodayAttendanceState.noAttendanceToday() = _NoAttendanceToday;

  /// The state when an error occurred while fetching today's attendance.
  const factory TodayAttendanceState.failure(
    /// The failure details.
    Failure failure,
  ) = _Failure;
}
