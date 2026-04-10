import '../../../../utils/utils_export.dart';
import '../entities/attendance_entity/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

/// A use case that retrieves a monthly history of attendance records.
///
/// This use case interacts with the [AttendanceRepository] to get all
/// attendance records for a given [month] and [year].
///
/// See also:
/// * [AttendanceRepository], which this use case depends on.
/// * [AttendanceEntity], the records returned by this use case.
class FetchMonthlyAttendanceUseCase {
  /// Creates a [FetchMonthlyAttendanceUseCase] with the given repository.
  FetchMonthlyAttendanceUseCase(this._attendanceRepository);

  final AttendanceRepository _attendanceRepository;

  /// Fetches a list of attendance records for the specified [month] and [year].
  ///
  /// Setting [forceRefresh] to true triggers a fresh fetch from the remote
  /// source, bypassing local caches.
  /// Returns a [Result] containing a list of [AttendanceEntity] objects.
  Future<Result<List<AttendanceEntity>>> call({
    required int month,
    required int year,
    bool forceRefresh = false,
  }) async => await _attendanceRepository.fetchMonthlyAttendance(
    month: month,
    year: year,
    forceRefresh: forceRefresh,
  );
}
