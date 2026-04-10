/// The available time-based filters for attendance history.
///
/// This enum is used to filter a list of attendance records based on
/// specific periods such as today, yesterday, or current month.
enum AttendanceFilter {
  /// Records from the last seven days including today.
  sevenDays,

  /// Records only for the current day.
  today,

  /// Records only for the previous day.
  yesterday,

  /// Records from the start of the current week until today.
  thisWeek,

  /// Records for the entire current month.
  thisMonth,
}

/// Extensions to provide human-readable labels for [AttendanceFilter].
extension AttendanceFilterLabel on AttendanceFilter {
  /// The display label for the filter in Indonesian.
  String get label {
    switch (this) {
      case AttendanceFilter.sevenDays:
        return 'Last 7 days';
      case AttendanceFilter.today:
        return 'Today';
      case AttendanceFilter.yesterday:
        return 'Yesterday';
      case AttendanceFilter.thisWeek:
        return 'This week';
      case AttendanceFilter.thisMonth:
        return 'This month';
    }
  }
}
