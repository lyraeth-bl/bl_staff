import '../../domain/entities/attendance_entity/attendance_entity.dart';
import '../models/attendance_model/attendance_model.dart';

extension AttendanceModelMapper on AttendanceModel {
  AttendanceEntity toEntity() => AttendanceEntity(
    id: id,
    date: date,
    checkIn: checkIn,
    checkOut: checkOut,
    status: status,
  );
}

extension AttendanceEntityMapper on AttendanceEntity {
  AttendanceModel toModel() => AttendanceModel(
    id: id,
    date: date,
    checkIn: checkIn,
    checkOut: checkOut,
    status: status,
  );
}
