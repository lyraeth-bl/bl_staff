import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/attendance_entity/attendance_entity.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

/// A data transfer object representing an attendance record.
///
/// This model is used for serializing and deserializing attendance data
/// from external sources, such as a remote API or local database.
///
/// See also:
/// * [AttendanceEntity], the domain entity this model maps to.
@freezed
abstract class AttendanceModel with _$AttendanceModel {
  /// Creates an [AttendanceModel] with the given attendance data.
  const factory AttendanceModel({
    /// The unique identifier for this attendance record.
    required int id,

    /// The date this attendance record refers to.
    required DateTime date,

    /// The specific time the staff member clocked in.
    @JsonKey(name: "check_in") DateTime? checkIn,

    /// The specific time the staff member clocked out.
    @JsonKey(name: "check_out") DateTime? checkOut,

    /// The status of this attendance record.
    required AttendanceStatus status,
  }) = _AttendanceModel;

  /// Creates an [AttendanceModel] from a JSON map.
  ///
  /// Returns an [AttendanceModel] instance populated with the data from [json].
  factory AttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceModelFromJson(json);
}
