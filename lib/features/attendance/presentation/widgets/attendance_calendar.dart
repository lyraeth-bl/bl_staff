import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../domain/entities/attendance_entity/attendance_entity.dart';
import '../bloc/attendance_bloc.dart';

/// A calendar widget that displays attendance status for each day.
///
/// This widget uses [TableCalendar] to provide a monthly view of attendance.
/// It marks each day with a color-coded dot representing the attendance
/// status. When a month is changed, it triggers a fetch for that month's
/// data via [AttendanceBloc].
///
/// See also:
/// * [AttendanceStatus], for the meaning of different marker colors.
class AttendanceCalendar extends StatefulWidget {
  /// Creates an [AttendanceCalendar].
  const AttendanceCalendar({super.key, this.onDayTapped, this.onMonthChanged});

  /// Called when a specific day on the calendar is tapped.
  final ValueChanged<AttendanceEntity?>? onDayTapped;

  /// Called when the calendar page changes to a different month or year.
  final void Function(int month, int year)? onMonthChanged;

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final attendances = state.maybeWhen(
          success: (attendances, _, _, _) => attendances,
          orElse: () => <AttendanceEntity>[],
        );

        final Map<DateTime, List<AttendanceEntity>> groupedAttendances = {};
        for (var a in attendances) {
          final dateKey = DateTime(a.date.year, a.date.month, a.date.day);
          // Kalau belum ada, bikin list kosong [], lalu tambahin [a] ke dalamnya
          groupedAttendances.putIfAbsent(dateKey, () => []).add(a);
        }

        return TableCalendar<AttendanceEntity>(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          eventLoader: (day) {
            final dateKey = DateTime(day.year, day.month, day.day);
            return groupedAttendances[dateKey] ?? [];
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });

            final match = attendances
                .where((a) => isSameDay(a.date, selectedDay))
                .firstOrNull;
            widget.onDayTapped?.call(match);
          },
          onPageChanged: (focusedDay) {
            setState(() => _focusedDay = focusedDay);
            context.read<AttendanceBloc>().add(
              AttendanceEvent.monthChanged(
                month: focusedDay.month,
                year: focusedDay.year,
              ),
            );

            widget.onMonthChanged?.call(focusedDay.month, focusedDay.year);
          },
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {
              if (events.isEmpty) return const SizedBox.shrink();

              final attendance = events.first;
              final color = _statusColor(attendance.status, colorScheme);

              return Positioned(
                bottom: 4,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: (isSameDay(day, _selectedDay))
                        ? colorScheme.onPrimaryContainer
                        : color,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
            leftChevronIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: const Icon(LucideIcons.chevronLeft),
            ),
            rightChevronIcon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.outlineVariant),
              ),
              child: const Icon(LucideIcons.chevronRight),
            ),
          ),
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,

            todayDecoration: BoxDecoration(
              color: colorScheme.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            todayTextStyle: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),

            selectedDecoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            selectedTextStyle: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),

            defaultTextStyle: TextStyle(color: colorScheme.onSurface),
            weekendTextStyle: TextStyle(color: colorScheme.error),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
            weekendStyle: TextStyle(
              color: colorScheme.error.withValues(alpha: 0.8),
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  Color _statusColor(AttendanceStatus status, ColorScheme colorScheme) {
    switch (status) {
      case AttendanceStatus.hadir:
        return colorScheme.primary;
      case AttendanceStatus.terlambat:
        return colorScheme.tertiary;
      case AttendanceStatus.absen:
        return colorScheme.error;
      case AttendanceStatus.lupaCheckin:
      case AttendanceStatus.lupaCheckout:
        return colorScheme.secondary;
      case AttendanceStatus.belumAbsen:
        return colorScheme.outline;
    }
  }
}
