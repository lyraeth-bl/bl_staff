part of 'attendance_bloc.dart';

/// The various states of the [AttendanceBloc].
@freezed
abstract class AttendanceState with _$AttendanceState {
  /// The initial state before any action has been taken.
  const factory AttendanceState.initial() = _Initial;

  /// The state when attendance data is being fetched.
  const factory AttendanceState.loading() = _Loading;

  /// The state when attendance data has been successfully retrieved.
  const factory AttendanceState.success({
    /// The list of attendance records retrieved.
    required List<AttendanceEntity> attendances,

    /// Pre-computed summary derived from [attendances].
    /// Widgets should read totals from here instead of filtering the list.
    required AttendanceSummary summary,

    /// The month for which the data was retrieved.
    required int month,

    /// The year for which the data was retrieved.
    required int year,
  }) = _Success;

  /// The state when an error occurred while fetching data.
  const factory AttendanceState.failure({
    /// The failure that caused this state.
    required Failure failure,

    /// The last successfully fetched attendance list, if any.
    /// May be null when no prior successful fetch has occurred.
    List<AttendanceEntity>? lastAttendances,

    /// The pre-computed summary for [lastAttendances], if available.
    AttendanceSummary? lastSummary,

    /// The month of the last known data.
    required int lastMonth,

    /// The year of the last known data.
    required int lastYear,
  }) = _Failure;
}
