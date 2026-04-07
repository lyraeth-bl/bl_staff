class AttendanceBarData {
  const AttendanceBarData({
    required this.date,
    required this.hoursWorked,
    required this.status,
  });

  final DateTime date;
  final double hoursWorked;
  final String status;
}

List<AttendanceBarData> parseWeeklyData(List<dynamic> apiData) {
  final now = DateTime.now();

  // cari Senin minggu ini
  final monday = now.subtract(Duration(days: now.weekday - 1));

  return List.generate(7, (i) {
    final day = DateTime(monday.year, monday.month, monday.day + i);
    final dayStr =
        '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';

    final found = apiData.firstWhere(
      (e) => e['date'] == dayStr,
      orElse: () => null,
    );

    if (found == null) {
      // hari ini belum ada data / weekend / libur
      return AttendanceBarData(date: day, hoursWorked: 0, status: 'absen');
    }

    final status = found['status'] as String;
    final checkIn = found['check_in'] != null
        ? DateTime.parse(found['check_in'])
        : null;
    final checkOut = found['check_out'] != null
        ? DateTime.parse(found['check_out'])
        : null;

    double hours = 0;

    switch (status) {
      case 'absen':
        hours = 0;
        break;
      case 'lupa_checkin':
      case 'lupa_checkout':
        hours = 8.0;
        break;
      case 'hadir':
      case 'terlambat':
      default:
        if (checkIn != null && checkOut != null) {
          hours = checkOut.difference(checkIn).inMinutes / 60.0;
        }
        break;
    }

    return AttendanceBarData(
      date: day,
      hoursWorked: hours.clamp(0, 12),
      status: status,
    );
  });
}
