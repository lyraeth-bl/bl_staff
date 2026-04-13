import 'package:bl_staff/utils/shared/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/attendance_entity/attendance_entity.dart';

/// A card that displays the user's attendance status for today.
///
/// This widget uses different colors and icons based on the [status] to
/// provide visual feedback on whether the user has clocked in, is late,
/// or is absent.
class TodayStatusCard extends StatelessWidget {
  /// Creates a [TodayStatusCard].
  const TodayStatusCard({super.key, required this.status});

  /// The attendance status for today.
  final AttendanceStatus status;

  @override
  Widget build(BuildContext context) {
    final config = _statusConfig(context);
    return Card.outlined(
      color: config.backgroundColor,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: config.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: config.iconBackgroundColor,
              foregroundColor: config.iconColor,
              child: Icon(config.icon, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today status",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: config.subtitleColor),
                ),
                Text(
                  config.label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: config.titleColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _StatusConfig _statusConfig(BuildContext context) {
    switch (status) {
      case AttendanceStatus.hadir:
        return _StatusConfig(
          label: "Present",
          icon: LucideIcons.circleCheck,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          borderColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.3),
          iconBackgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.15),
          iconColor: Theme.of(context).colorScheme.primary,
          titleColor: Theme.of(context).colorScheme.primary,
          subtitleColor: Theme.of(context).colorScheme.onPrimaryContainer,
        );
      case AttendanceStatus.terlambat:
        return _StatusConfig(
          label: "Late",
          icon: LucideIcons.clock,
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          borderColor: Theme.of(
            context,
          ).colorScheme.tertiary.withValues(alpha: 0.3),
          iconBackgroundColor: Theme.of(
            context,
          ).colorScheme.tertiary.withValues(alpha: 0.15),
          iconColor: Theme.of(context).colorScheme.tertiary,
          titleColor: Theme.of(context).colorScheme.tertiary,
          subtitleColor: Theme.of(context).colorScheme.onTertiaryContainer,
        );
      case AttendanceStatus.absen:
        return _StatusConfig(
          label: "Absent",
          icon: LucideIcons.circleX,
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          borderColor: Theme.of(
            context,
          ).colorScheme.error.withValues(alpha: 0.3),
          iconBackgroundColor: Theme.of(
            context,
          ).colorScheme.error.withValues(alpha: 0.15),
          iconColor: Theme.of(context).colorScheme.error,
          titleColor: Theme.of(context).colorScheme.error,
          subtitleColor: Theme.of(context).colorScheme.onErrorContainer,
        );
      case AttendanceStatus.lupaCheckin:
        return _StatusConfig(
          label: "Forget to check in",
          icon: LucideIcons.circleQuestionMark,
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          borderColor: Theme.of(
            context,
          ).colorScheme.error.withValues(alpha: 0.3),
          iconBackgroundColor: Theme.of(
            context,
          ).colorScheme.error.withValues(alpha: 0.15),
          iconColor: Theme.of(context).colorScheme.error,
          titleColor: Theme.of(context).colorScheme.error,
          subtitleColor: Theme.of(context).colorScheme.onErrorContainer,
        );
      case AttendanceStatus.lupaCheckout:
        return _StatusConfig(
          label: "Forget to check out",
          icon: LucideIcons.circleQuestionMark,
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          borderColor: Theme.of(
            context,
          ).colorScheme.error.withValues(alpha: 0.3),
          iconBackgroundColor: Theme.of(
            context,
          ).colorScheme.error.withValues(alpha: 0.15),
          iconColor: Theme.of(context).colorScheme.error,
          titleColor: Theme.of(context).colorScheme.error,
          subtitleColor: Theme.of(context).colorScheme.onErrorContainer,
        );
      case AttendanceStatus.belumAbsen:
        return _StatusConfig(
          label: "Not yet clock in",
          icon: LucideIcons.circleQuestionMark,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          borderColor: Theme.of(context).colorScheme.outlineVariant,
          iconBackgroundColor: Theme.of(
            context,
          ).colorScheme.surfaceContainerHigh,
          iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
          titleColor: Theme.of(context).colorScheme.onSurface,
          subtitleColor: Theme.of(context).colorScheme.onSurfaceVariant,
        );
    }
  }
}

class _StatusConfig {
  const _StatusConfig({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.titleColor,
    required this.subtitleColor,
  });

  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color titleColor;
  final Color subtitleColor;
}

class TodayStatusCardShimmer extends StatelessWidget {
  const TodayStatusCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Theme.of(context).colorScheme.surfaceContainerHighest;
    final highlightColor = Theme.of(context).colorScheme.surface;

    return Card.outlined(
      color: Theme.of(context).colorScheme.surfaceContainer,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: CircleAvatar(radius: 20, backgroundColor: Colors.white),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: 100,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    width: 120,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ].separatedBy(6.h),
            ),
          ].separatedBy(12.w),
        ),
      ),
    );
  }
}
