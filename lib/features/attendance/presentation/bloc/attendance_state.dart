part of 'attendance_bloc.dart';

@freezed
abstract class AttendanceState with _$AttendanceState {
  const factory AttendanceState.initial() = _Initial;

  const factory AttendanceState.loading() = _Loading;

  const factory AttendanceState.success({
    required List<AttendanceEntity> attendances,
    required int month,
    required int year,
  }) = _Success;

  const factory AttendanceState.failure(Failure failure) = _Failure;
}
