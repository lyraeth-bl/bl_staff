import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/shared/extension/extension.dart';
import '../../domain/entities/attendance_summary/attendance_summary.dart';
import '../bloc/attendance_bloc.dart';

/// A card that displays a summary of the current month's attendance records.
///
/// Reads the pre-computed [AttendanceSummary] directly from [AttendanceBloc]
/// state — no filtering or counting happens inside this widget.
///
/// Shows a shimmer/loading state while data is being fetched, and falls back
/// to the last known summary when the BLoC is in a failure state.
class AttendanceSummaryCard extends StatelessWidget {
  /// Creates an [AttendanceSummaryCard].
  const AttendanceSummaryCard({super.key, this.isWidgetForDashboard = false});

  final bool isWidgetForDashboard;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final summary = state.whenOrNull(
          success: (_, summary, _, _) => summary,
          failure: (_, _, lastSummary, _, _) => lastSummary,
        );

        final isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        return _SummaryCardLayout(
          isLoading: isLoading,
          summary: summary,
          isWidgetForDashboard: isWidgetForDashboard,
        );
      },
    );
  }
}

class _SummaryCardLayout extends StatelessWidget {
  const _SummaryCardLayout({
    required this.isLoading,
    required this.summary,
    this.isWidgetForDashboard = false,
  });

  final bool isLoading;
  final bool isWidgetForDashboard;
  final AttendanceSummary? summary;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (isWidgetForDashboard) {
      return Card.outlined(
        margin: EdgeInsets.zero,
        color: colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  'Attendance Monthly Summary',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: _SummaryTile(
                        label: 'Present',
                        count: summary?.totalHadir,
                        color: Colors.green,
                        isLoading: isLoading,
                      ),
                    ),
                    VerticalDivider(
                      width: 0.3,
                      radius: BorderRadius.circular(4),
                      thickness: 0.3,
                      color: colorScheme.outline,
                    ),
                    Expanded(
                      child: _SummaryTile(
                        label: 'Late',
                        count: summary?.totalTerlambat,
                        color: Colors.orange,
                        isLoading: isLoading,
                      ),
                    ),
                    VerticalDivider(
                      width: 0.3,
                      radius: BorderRadius.circular(4),
                      thickness: 0.3,
                      color: colorScheme.outline,
                    ),
                    Expanded(
                      child: _SummaryTile(
                        label: 'Absent',
                        count: summary?.totalAbsen,
                        color: Colors.red,
                        isLoading: isLoading,
                      ),
                    ),
                    VerticalDivider(
                      width: 0.3,
                      radius: BorderRadius.circular(4),
                      thickness: 0.3,
                      color: colorScheme.outline,
                    ),
                    Expanded(
                      child: _SummaryTile(
                        label: 'Forget',
                        count: summary != null
                            ? summary!.totalLupaCheckin +
                                  summary!.totalLupaCheckout
                            : null,
                        color: Colors.blueGrey,
                        isLoading: isLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ].separatedBy(16.h),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(left: 8, top: 24, right: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              'Monthly Summary',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _SummaryTile(
                    label: 'Present',
                    count: summary?.totalHadir,
                    color: Colors.green,
                    isLoading: isLoading,
                  ),
                ),
                VerticalDivider(
                  width: 0.3,
                  radius: BorderRadius.circular(4),
                  thickness: 0.3,
                  color: colorScheme.outline,
                ),
                Expanded(
                  child: _SummaryTile(
                    label: 'Late',
                    count: summary?.totalTerlambat,
                    color: Colors.orange,
                    isLoading: isLoading,
                  ),
                ),
                VerticalDivider(
                  width: 0.3,
                  radius: BorderRadius.circular(4),
                  thickness: 0.3,
                  color: colorScheme.outline,
                ),
                Expanded(
                  child: _SummaryTile(
                    label: 'Absent',
                    count: summary?.totalAbsen,
                    color: Colors.red,
                    isLoading: isLoading,
                  ),
                ),
                VerticalDivider(
                  width: 0.3,
                  radius: BorderRadius.circular(4),
                  thickness: 0.3,
                  color: colorScheme.outline,
                ),
                Expanded(
                  child: _SummaryTile(
                    label: 'Forget',
                    // Lupa checkin + lupa checkout digabung di tile ini.
                    // Pisah jadi 2 tile kalau UI-nya muat.
                    count: summary != null
                        ? summary!.totalLupaCheckin + summary!.totalLupaCheckout
                        : null,
                    color: Colors.blueGrey,
                    isLoading: isLoading,
                  ),
                ),
              ],
            ),
          ),
        ].separatedBy(16.h),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.count,
    required this.color,
    required this.isLoading,
  });

  final String label;
  final int? count;
  final Color color;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        isLoading || count == null
            ? Container(
                width: 36,
                height: 28,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
              )
            : Text(
                '$count',
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
        Text(
          label,
          style: textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ].separatedBy(4.h),
    );
  }
}
