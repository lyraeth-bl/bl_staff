import 'package:collection/collection.dart';

import '../../domain/entities/attendance_entity/attendance_entity.dart';

class AttendanceBarData {
  const AttendanceBarData({
    required this.date,
    required this.hoursWorked,
    required this.status,
  });

  final DateTime date;
  final double hoursWorked;
  final AttendanceStatus status;
}

List<AttendanceBarData> parseWeeklyData(List<AttendanceEntity> attendances) {
  final now = DateTime.now();

  // cari Senin minggu ini
  final monday = now.subtract(Duration(days: now.weekday - 1));

  return List.generate(7, (i) {
    final day = DateTime(monday.year, monday.month, monday.day + i);

    final found = attendances.firstWhereOrNull(
      (e) =>
          e.date.year == day.year &&
          e.date.month == day.month &&
          e.date.day == day.day,
    );

    if (found == null) {
      // hari ini belum ada data / weekend / libur
      return AttendanceBarData(
        date: day,
        hoursWorked: 0,
        status: AttendanceStatus.absen,
      );
    }

    double hours = switch (found.status) {
      // Set jam kerja ke 0 jika tidak masuk.
      AttendanceStatus.absen => 0,
      // Staff yang lupa checkin atau lupa checkout tetap di anggap masuk.
      // jadi kita set fix jam kerjanya ke 8 jam.
      AttendanceStatus.lupaCheckin || AttendanceStatus.lupaCheckout => 8.0,
      AttendanceStatus.hadir || AttendanceStatus.terlambat => () {
        if (found.checkIn != null && found.checkOut != null) {
          return found.checkOut!.difference(found.checkIn!).inMinutes / 60.0;
        }
        return 0.0;
      }(),
    };

    return AttendanceBarData(
      date: day,
      hoursWorked: hours.clamp(0, 12),
      status: found.status,
    );
  });
}
