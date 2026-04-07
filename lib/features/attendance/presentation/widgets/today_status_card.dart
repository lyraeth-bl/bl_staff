import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../domain/entities/attendance_entity/attendance_entity.dart';

class TodayStatusCard extends StatelessWidget {
  const TodayStatusCard({super.key});

  static const _status = AttendanceStatus.hadir;

  @override
  Widget build(BuildContext context) {
    final config = _statusConfig(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: config.borderColor),
      ),
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
                "Status hari ini",
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
    );
  }

  _StatusConfig _statusConfig(BuildContext context) {
    switch (_status) {
      case AttendanceStatus.hadir:
        return _StatusConfig(
          label: "Hadir",
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
          label: "Terlambat",
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
          label: "Tidak Hadir",
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
          label: "Lupa Check in",
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
      case AttendanceStatus.lupaCheckout:
        return _StatusConfig(
          label: "Lupa Check out",
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
