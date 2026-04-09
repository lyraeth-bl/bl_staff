import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_entity.freezed.dart';

/// The various states of a staff member's attendance for a specific day.
///
/// This enum represents whether a staff member was present, late, absent,
/// or has missing clock-in/out data.
enum AttendanceStatus {
  /// The staff member was present and on time.
  hadir,

  /// The staff member arrived after the designated start time.
  terlambat,

  /// The staff member did not attend work.
  absen,

  /// The staff member attended but failed to record their arrival.
  lupaCheckin,

  /// The staff member attended but failed to record their departure.
  lupaCheckout,

  /// No attendance record has been recorded yet for the day.
  belumAbsen,
}

/// A representation of a staff member's attendance record for a single day.
///
/// This entity contains the unique identifier, date, specific clock-in and
/// clock-out times, and the calculated status of the attendance.
///
/// See also:
/// * [AttendanceStatus], for the possible states of an attendance record.
@freezed
abstract class AttendanceEntity with _$AttendanceEntity {
  /// Creates an [AttendanceEntity] with the given attendance data.
  const factory AttendanceEntity({
    /// The unique identifier for this attendance record.
    required int id,

    /// The date this attendance record refers to.
    required DateTime date,

    /// The specific time the staff member clocked in.
    DateTime? checkIn,

    /// The specific time the staff member clocked out.
    DateTime? checkOut,

    /// The calculated status of this attendance record.
    required AttendanceStatus status,
  }) = _AttendanceEntity;
}
