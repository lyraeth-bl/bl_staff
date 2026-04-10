import '../../../../utils/utils_export.dart';
import '../entities/attendance_entity/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

/// A use case that retrieves the staff member's attendance for the current day.
///
/// This use case interacts with the [AttendanceRepository] to get the
/// attendance status and record details for today.
///
/// See also:
/// * [AttendanceRepository], which this use case depends on.
/// * [AttendanceEntity], the record returned by this use case.
class FetchTodayAttendanceUseCase {
  /// Creates a [FetchTodayAttendanceUseCase] with the given repository.
  FetchTodayAttendanceUseCase(this._attendanceRepository);

  final AttendanceRepository _attendanceRepository;

  /// Fetches the attendance record for the current day.
  ///
  /// Setting [forceRefresh] to true triggers a fresh fetch from the remote
  /// source, bypassing local caches.
  /// Returns a [Result] containing the [AttendanceEntity] for today if it
  /// exists, otherwise returns null.
  Future<Result<AttendanceEntity?>> call({bool forceRefresh = false}) async =>
      await _attendanceRepository.fetchTodayAttendance(
        forceRefresh: forceRefresh,
      );
}
