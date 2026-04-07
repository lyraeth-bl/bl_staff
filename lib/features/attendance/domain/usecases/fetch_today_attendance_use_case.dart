import '../../../../utils/utils_export.dart';
import '../entities/attendance_entity/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

class FetchTodayAttendanceUseCase {
  FetchTodayAttendanceUseCase(this._attendanceRepository);

  final AttendanceRepository _attendanceRepository;

  Future<Result<AttendanceEntity?>> call({bool forceRefresh = false}) async =>
      await _attendanceRepository.fetchTodayAttendance(
        forceRefresh: forceRefresh,
      );
}
