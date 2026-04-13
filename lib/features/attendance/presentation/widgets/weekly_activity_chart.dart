import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/attendance_entity/attendance_entity.dart';
import '../bloc/attendance_bloc.dart';
import 'attendance_weekly_bar_data.dart';

class WeeklyActivityChart extends StatefulWidget {
  const WeeklyActivityChart({super.key, required this.weeklyData});

  final List<AttendanceBarData> weeklyData;

  @override
  State<WeeklyActivityChart> createState() => _WeeklyActivityChartState();
}

class _WeeklyActivityChartState extends State<WeeklyActivityChart> {
  @override
  void initState() {
    super.initState();
    context.read<AttendanceBloc>().add(AttendanceEvent.started());
  }

  Color _barColor(BuildContext context, AttendanceStatus status) {
    return switch (status) {
      AttendanceStatus.absen => Theme.of(context).colorScheme.outlineVariant,
      _ => Theme.of(context).colorScheme.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final totalHours = widget.weeklyData.fold<double>(
      0,
      (sum, d) => sum + d.hoursWorked,
    );
    return Card.outlined(
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Activity",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(
                    "Weekly",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inverseSurface,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "${totalHours.toStringAsFixed(0)} h",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: BarChart(
                BarChartData(
                  maxY: 12,
                  minY: 0,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) =>
                          Theme.of(context).colorScheme.inverseSurface,
                      tooltipBorderRadius: BorderRadius.circular(8),
                      tooltipPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        final data = widget.weeklyData[groupIndex];
                        final hours = data.hoursWorked.toStringAsFixed(0);
                        return BarTooltipItem(
                          "$hours h",
                          Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onInverseSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                          return Text(
                            days[value.toInt()],
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: List.generate(widget.weeklyData.length, (i) {
                    final data = widget.weeklyData[i];
                    final thisDay = DateTime.now().day;
                    return BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: data.hoursWorked,
                          color: _barColor(context, data.status),
                          width: 20,
                          borderRadius: BorderRadius.circular(8),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            toY: 12,
                            color: (data.date.day == thisDay)
                                ? Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHigh
                                : Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
