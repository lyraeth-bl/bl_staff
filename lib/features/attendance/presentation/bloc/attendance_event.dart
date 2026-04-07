part of 'attendance_bloc.dart';

@freezed
abstract class AttendanceEvent with _$AttendanceEvent {
  const factory AttendanceEvent.started() = _Started;

  const factory AttendanceEvent.monthChanged({
    required int month,
    required int year,
  }) = _MonthChanged;

  const factory AttendanceEvent.refreshed() = _Refreshed;
}
