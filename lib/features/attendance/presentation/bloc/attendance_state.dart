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

    /// The month for which the data was retrieved.
    required int month,

    /// The year for which the data was retrieved.
    required int year,
  }) = _Success;

  /// The state when an error occurred while fetching data.
  const factory AttendanceState.failure({
    required Failure failure,
    List<AttendanceEntity>? lastAttendances,
    int? lastMonth,
    int? lastYear,
  }) = _Failure;
}
