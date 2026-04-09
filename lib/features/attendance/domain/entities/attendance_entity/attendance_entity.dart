import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_entity.freezed.dart';

enum AttendanceStatus {
  hadir,
  terlambat,
  absen,
  lupaCheckin,
  lupaCheckout,
  belumAbsen,
}

@freezed
abstract class AttendanceEntity with _$AttendanceEntity {
  const factory AttendanceEntity({
    required int id,
    required DateTime date,
    DateTime? checkIn,
    DateTime? checkOut,
    required AttendanceStatus status,
  }) = _AttendanceEntity;
}
