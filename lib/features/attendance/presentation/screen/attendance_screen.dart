import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../utils/utils_export.dart';
import '../../domain/entities/attendance_entity/attendance_entity.dart';
import '../../domain/entities/attendance_filtering.dart';
import '../bloc/attendance_bloc.dart';
import '../widgets/attendance_calendar.dart';
import '../widgets/attendance_history_container.dart';
import '../widgets/filter_sheet.dart';
import '../widgets/real_time_clock.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _AttendanceRefreshWrapper(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [_AttendanceAppBar(), _AttendanceContent()],
        ),
      ),
    );
  }
}

class _AttendanceRefreshWrapper extends StatefulWidget {
  const _AttendanceRefreshWrapper({required this.child});

  final Widget child;

  @override
  State<_AttendanceRefreshWrapper> createState() =>
      _AttendanceRefreshWrapperState();
}

class _AttendanceRefreshWrapperState extends State<_AttendanceRefreshWrapper> {
  Future<void> _onRefresh() async {
    final monthlyAttendanceCompleter = Completer<void>();

    context.read<AttendanceBloc>().add(AttendanceEvent.refreshed());

    late StreamSubscription monthlyAttendanceSubs;
    monthlyAttendanceSubs = context.read<AttendanceBloc>().stream.listen((
      state,
    ) {
      state.whenOrNull(
        failure: (failure) {
          monthlyAttendanceCompleter.complete();
          monthlyAttendanceSubs.cancel();
        },
        success: (_, _, _) {
          monthlyAttendanceCompleter.complete();
          monthlyAttendanceSubs.cancel();
        },
      );
    });

    return monthlyAttendanceCompleter.future;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: _onRefresh, child: widget.child);
  }
}

class _AttendanceAppBar extends StatelessWidget {
  const _AttendanceAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: false,
      toolbarHeight: 80,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(
        "Attendance",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _AttendanceContent extends StatefulWidget {
  const _AttendanceContent();

  @override
  State<_AttendanceContent> createState() => _AttendanceContentState();
}

class _AttendanceContentState extends State<_AttendanceContent> {
  AttendanceFilter _activeFilter = AttendanceFilter.sevenDays;
  int _activeMonth = DateTime.now().month;
  int _activeYear = DateTime.now().year;

  List<AttendanceEntity> _applyFilter(
    List<AttendanceEntity> attendances,
    AttendanceFilter filter,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isCurrentMonth = _activeMonth == now.month && _activeYear == now.year;

    List<AttendanceEntity> filtered;

    switch (filter) {
      case AttendanceFilter.today:
        filtered = !isCurrentMonth
            ? attendances
            : attendances.where((a) => isSameDay(a.date, today)).toList();
      case AttendanceFilter.yesterday:
        final yesterday = today.subtract(const Duration(days: 1));
        filtered = !isCurrentMonth
            ? attendances
            : attendances.where((a) => isSameDay(a.date, yesterday)).toList();
      case AttendanceFilter.thisWeek:
        final startOfWeek = today.subtract(Duration(days: today.weekday - 1));
        filtered = !isCurrentMonth
            ? attendances
            : attendances
                  .where(
                    (a) =>
                        !a.date.isBefore(startOfWeek) && !a.date.isAfter(today),
                  )
                  .toList();
      case AttendanceFilter.thisMonth:
        filtered = attendances;
      case AttendanceFilter.sevenDays:
        final sevenDaysAgo = today.subtract(const Duration(days: 6));
        filtered = !isCurrentMonth
            ? attendances
            : attendances
                  .where(
                    (a) =>
                        !a.date.isBefore(sevenDaysAgo) &&
                        !a.date.isAfter(today),
                  )
                  .toList();
    }

    return filtered.reversed.toList();
  }

  void _showFilterSheet() {
    Navigator.of(context).push(
      CupertinoSheetRoute<AttendanceFilter>(
        builder: (context) => FilterSheet(
          activeFilter: _activeFilter,
          onFilterSelected: (filter) {
            setState(() => _activeFilter = filter);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TodayText(),
            const RealTimeClock(
              style: TextStyle(fontSize: 75, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24, left: 8, right: 8),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(32)),
              ),
              child: AttendanceCalendar(
                onDayTapped: (attendance) =>
                    _showDayDetailSheet(context, attendance),
                onMonthChanged: (month, year) {
                  setState(() {
                    _activeMonth = month;
                    _activeYear = year;

                    final now = DateTime.now();
                    if (month != now.month || year != now.year) {
                      _activeFilter = AttendanceFilter.thisMonth;
                    } else {
                      _activeFilter = AttendanceFilter.sevenDays;
                    }
                  });
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 8, top: 24, right: 8),
              padding: const EdgeInsets.all(8),
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height * 0.4,
              ),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 24,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Attendance history",
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        GestureDetector(
                          onTap: _showFilterSheet,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.tune_rounded,
                                  size: 16,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _activeFilter.label,
                                  style: Theme.of(context).textTheme.labelMedium
                                      ?.copyWith(
                                        color: colorScheme.onPrimaryContainer,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _AttendanceHistoryList(
                    activeFilter: _activeFilter,
                    applyFilter: _applyFilter,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDayDetailSheet(BuildContext context, AttendanceEntity? attendance) {
    Navigator.of(context).push(
      CupertinoSheetRoute<void>(
        builder: (context) => DayDetailSheet(attendance: attendance),
      ),
    );
  }
}

class _AttendanceHistoryList extends StatelessWidget {
  const _AttendanceHistoryList({
    required this.activeFilter,
    required this.applyFilter,
  });

  final AttendanceFilter activeFilter;
  final List<AttendanceEntity> Function(
    List<AttendanceEntity>,
    AttendanceFilter,
  )
  applyFilter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: 48),
            child: Center(child: CircularProgressIndicator()),
          ),
          failure: (failure) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
            child: Center(
              child: Text(
                failure.displayMessage,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          success: (attendances, month, year) {
            final filtered = applyFilter(attendances, activeFilter);

            if (filtered.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 48),
                child: Center(child: Text("No attendance today.")),
              );
            }

            return Column(
              children: filtered
                  .map((a) => AttendanceHistoryContainer(attendance: a))
                  .toList(),
            );
          },
        );
      },
    );
  }
}

class _TodayText extends StatefulWidget {
  const _TodayText();

  @override
  State<_TodayText> createState() => _TodayTextState();
}

class _TodayTextState extends State<_TodayText> {
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
      child: Text(
        now.toFullStringDay,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
