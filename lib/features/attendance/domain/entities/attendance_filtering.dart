enum AttendanceFilter { sevenDays, today, yesterday, thisWeek, thisMonth }

extension AttendanceFilterLabel on AttendanceFilter {
  String get label {
    switch (this) {
      case AttendanceFilter.sevenDays:
        return '7 Hari Terakhir';
      case AttendanceFilter.today:
        return 'Hari Ini';
      case AttendanceFilter.yesterday:
        return 'Kemarin';
      case AttendanceFilter.thisWeek:
        return 'Minggu Ini';
      case AttendanceFilter.thisMonth:
        return 'Bulan Ini';
    }
  }
}
