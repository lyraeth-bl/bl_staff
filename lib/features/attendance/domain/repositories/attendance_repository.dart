import '../../../../utils/utils_export.dart';
import '../entities/attendance_entity/attendance_entity.dart';

/// A repository that manages attendance records.
///
/// This repository provides an interface for fetching attendance data,
/// including monthly history and current day status. Implementation
/// details regarding data persistence and remote synchronization are
/// handled by concrete implementations.
///
/// See also:
/// * [AttendanceEntity], for the data model of an attendance record.
abstract class AttendanceRepository {
  /// Fetches a list of attendance records for the specified [month] and [year].
  ///
  /// Setting [forceRefresh] to true triggers a fresh fetch from the remote
  /// source, bypassing local caches.
  /// Returns a [Result] containing a list of [AttendanceEntity] objects.
  Future<Result<List<AttendanceEntity>>> fetchMonthlyAttendance({
    required int month,
    required int year,
    bool forceRefresh = false,
  });

  /// Fetches the attendance record for the current day.
  ///
  /// Setting [forceRefresh] to true triggers a fresh fetch from the remote
  /// source, bypassing local caches.
  /// Returns a [Result] containing the [AttendanceEntity] for today if it
  /// exists, otherwise returns null.
  Future<Result<AttendanceEntity?>> fetchTodayAttendance({
    bool forceRefresh = false,
  });
}
