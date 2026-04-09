import 'package:flutter/material.dart';

import '../../domain/entities/attendance_entity/attendance_entity.dart';
import '../../domain/entities/attendance_filtering.dart';
import 'attendance_history_container.dart';

class FilterSheet extends StatelessWidget {
  const FilterSheet({
    super.key,
    required this.activeFilter,
    required this.onFilterSelected,
  });

  final AttendanceFilter activeFilter;
  final ValueChanged<AttendanceFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Attendance Filters",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ...AttendanceFilter.values.map(
                      (filter) => _FilterTile(
                        filter: filter,
                        isActive: filter == activeFilter,
                        onTap: () => onFilterSelected(filter),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterTile extends StatelessWidget {
  const _FilterTile({
    required this.filter,
    required this.isActive,
    required this.onTap,
  });

  final AttendanceFilter filter;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        filter.label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isActive ? colorScheme.primary : colorScheme.onSurface,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isActive
          ? Icon(Icons.check_rounded, color: colorScheme.primary)
          : null,
    );
  }
}

class DayDetailSheet extends StatelessWidget {
  const DayDetailSheet({super.key, required this.attendance});

  final AttendanceEntity? attendance;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (attendance == null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 48),
                  child: Center(
                    child: Text(
                      "There's no attendance for today",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                )
              else
                AttendanceHistoryContainer(attendance: attendance!),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
