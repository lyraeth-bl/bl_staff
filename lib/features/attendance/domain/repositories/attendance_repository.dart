import '../../../../utils/utils_export.dart';
import '../entities/attendance_entity/attendance_entity.dart';

abstract class AttendanceRepository {
  Future<Result<List<AttendanceEntity>>> fetchMonthlyAttendance({
    required int month,
    required int year,
    bool forceRefresh = false,
  });

  Future<Result<AttendanceEntity?>> fetchTodayAttendance({
    bool forceRefresh = false,
  });
}
