import 'package:flutter/material.dart';

import '../../../../utils/shared/extension/extension.dart';
import '../../domain/entities/attendance_entity/attendance_entity.dart';

/// A card-like widget that displays the details of an attendance record.
///
/// This container shows the day of the week, the date, clock-in/out times,
/// the calculated work duration, and the attendance status as a chip.
/// The background color adjusts based on the date (e.g., highlighting weekends).
class AttendanceHistoryContainer extends StatelessWidget {
  /// Creates an [AttendanceHistoryContainer].
  const AttendanceHistoryContainer({super.key, required this.attendance});

  /// The attendance record to display.
  final AttendanceEntity attendance;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final date = attendance.date;

    final containerColor = date.attendanceContainerColor(colorScheme);
    final onContainerColor = date.attendanceOnContainerColor(colorScheme);
    final chipColor = date.attendanceChipColor(colorScheme);
    final onChipColor = date.attendanceOnChipColor(colorScheme);

    final checkInStr = attendance.checkIn?.toHourMinuteFormat ?? '- - : - -';
    final checkOutStr = attendance.checkOut?.toHourMinuteFormat ?? '- - : - -';
    final dayStr = date.toFullStringDay;
    final statusStr = attendance.status.label;
    final dateStr = attendance.date.toDayMonthYearFormat;

    String durationStr = '--';
    if (attendance.checkIn != null && attendance.checkOut != null) {
      final diff = attendance.checkOut!.difference(attendance.checkIn!);
      final hours = diff.inHours;
      final minutes = diff.inMinutes.remainder(60);
      durationStr = '${hours}j ${minutes}m';
    }

    return Card.outlined(
      margin: const EdgeInsets.only(top: 16),
      color: containerColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dayStr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: onContainerColor,
                      ),
                    ),
                    Text(dateStr, style: TextStyle(color: onContainerColor)),
                  ],
                ),
                Chip(
                  label: Text(
                    statusStr,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: onChipColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: chipColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      checkInStr,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: onContainerColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Check in",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: onContainerColor),
                    ),
                  ],
                ),
                Chip(
                  label: Text(
                    durationStr,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: onChipColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: chipColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide.none,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      checkOutStr,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: onContainerColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Check out",
                      style: Theme.of(
                        context,
                      ).textTheme.titleSmall?.copyWith(color: onContainerColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
