part of 'attendance_bloc.dart';

/// The events handled by the [AttendanceBloc].
@freezed
abstract class AttendanceEvent with _$AttendanceEvent {
  /// Initial event to start loading the attendance data.
  const factory AttendanceEvent.started() = _Started;

  /// Event triggered when the selected month or year is changed.
  const factory AttendanceEvent.monthChanged({
    /// The new month to fetch data for.
    required int month,

    /// The new year to fetch data for.
    required int year,
  }) = _MonthChanged;

  /// Event triggered to manually refresh the attendance data.
  const factory AttendanceEvent.refreshed() = _Refreshed;
}
