import '../../domain/entities/attendance_entity/attendance_entity.dart';
import '../models/attendance_model/attendance_model.dart';

/// Extensions for mapping [AttendanceModel] to domain entities.
extension AttendanceModelMapper on AttendanceModel {
  /// Converts this [AttendanceModel] into an [AttendanceEntity].
  ///
  /// Returns an [AttendanceEntity] with the same data.
  AttendanceEntity toEntity() => AttendanceEntity(
    id: id,
    date: date,
    checkIn: checkIn,
    checkOut: checkOut,
    status: status,
  );
}

/// Extensions for mapping [AttendanceEntity] to data models.
extension AttendanceEntityMapper on AttendanceEntity {
  /// Converts this [AttendanceEntity] into an [AttendanceModel].
  ///
  /// Returns an [AttendanceModel] with the same data.
  AttendanceModel toModel() => AttendanceModel(
    id: id,
    date: date,
    checkIn: checkIn,
    checkOut: checkOut,
    status: status,
  );
}
