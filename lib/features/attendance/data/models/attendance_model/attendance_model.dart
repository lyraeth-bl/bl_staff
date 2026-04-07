import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/attendance_entity/attendance_entity.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

@freezed
abstract class AttendanceModel with _$AttendanceModel {
  const factory AttendanceModel({
    required int id,
    required DateTime date,
    @JsonKey(name: "check_in") DateTime? checkIn,
    @JsonKey(name: "check_out") DateTime? checkOut,
    required AttendanceStatus status,
  }) = _AttendanceModel;

  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);
}
