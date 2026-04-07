import '../../../../utils/utils_export.dart';
import '../entities/attendance_entity/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class FetchMonthlyAttendanceUseCase {
  FetchMonthlyAttendanceUseCase(this._attendanceRepository);

  final AttendanceRepository _attendanceRepository;

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
