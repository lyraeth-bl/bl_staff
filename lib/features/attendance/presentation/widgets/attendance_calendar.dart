import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../domain/entities/attendance_entity/attendance_entity.dart';
import '../bloc/attendance_bloc.dart';

class AttendanceCalendar extends StatefulWidget {
  const AttendanceCalendar({super.key, this.onDayTapped, this.onMonthChanged});

  final ValueChanged<AttendanceEntity?>? onDayTapped;
  final void Function(int month, int year)? onMonthChanged;

  @override
  State<AttendanceCalendar> createState() => _AttendanceCalendarState();
}

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  List<AttendanceEntity> _getEventsForDay(
    DateTime day,
    List<AttendanceEntity> attendances,
  ) {
    return attendances.where((a) => isSameDay(a.date, day)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final attendances = state.maybeWhen(
          success: (attendances, _, __) => attendances,
          orElse: () => <AttendanceEntity>[],
        );

        return TableCalendar<AttendanceEntity>(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          calendarFormat: CalendarFormat.month,
          startingDayOfWeek: StartingDayOfWeek.monday,
          eventLoader: (day) => _getEventsForDay(day, attendances),
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
                    color: color,
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
            defaultDecoration: const BoxDecoration(shape: BoxShape.rectangle),
            weekendDecoration: const BoxDecoration(shape: BoxShape.rectangle),
            holidayDecoration: const BoxDecoration(shape: BoxShape.rectangle),
            outsideDecoration: const BoxDecoration(shape: BoxShape.rectangle),
            disabledDecoration: const BoxDecoration(shape: BoxShape.rectangle),
            todayDecoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
            todayTextStyle: TextStyle(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
            selectedDecoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle,
            ),
            selectedTextStyle: TextStyle(
              color: colorScheme.onSurface,
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
