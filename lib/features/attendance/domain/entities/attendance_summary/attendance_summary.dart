import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_summary.freezed.dart';

/// A summary of a staff member's attendance records for a given month.
///
/// This entity is derived from a list of [AttendanceEntity] objects and
/// provides aggregated counts for each [AttendanceStatus] variant.
/// It is computed in the presentation layer and stored directly in
/// [AttendanceState] to avoid redundant recalculation on every build.
///
/// See also:
/// * [AttendanceStatus], for the possible states of an attendance record.
/// * [AttendanceState], where this summary is carried inside the success state.
@freezed
abstract class AttendanceSummary with _$AttendanceSummary {
  /// Creates an [AttendanceSummary] with aggregated counts.
  const factory AttendanceSummary({
    /// Total days the staff member was present and on time.
    required int totalHadir,

    /// Total days the staff member arrived late.
    required int totalTerlambat,

    /// Total days the staff member was absent.
    required int totalAbsen,

    /// Total days the staff member forgot to clock in.
    required int totalLupaCheckin,

    /// Total days the staff member forgot to clock out.
    required int totalLupaCheckout,
  }) = _AttendanceSummary;
}
