import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../attendance/presentation/widgets/attendance_weekly_bar_data.dart';
import '../../../user/presentation/bloc/user_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    return _DashboardRefreshWrapper(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        body: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [_DashboardAppBar(), _DashboardContent()],
        ),
      ),
    );
  }
}

class _DashboardRefreshWrapper extends StatefulWidget {
  const _DashboardRefreshWrapper({required this.child});

  final Widget child;

  @override
  State<_DashboardRefreshWrapper> createState() =>
      _DashboardRefreshWrapperState();
}

class _DashboardRefreshWrapperState extends State<_DashboardRefreshWrapper> {
  Future<void> _onRefresh() async {
    final completer = Completer<void>();

    context.read<UserBloc>().add(UserEvent.fetchUser(forceRefresh: true));

    late final StreamSubscription subscription;

    subscription = context.read<UserBloc>().stream.listen((state) {
      state.whenOrNull(
        success: (_) {
          completer.complete();
          subscription.cancel();
        },
        failure: (_) {
          completer.complete();
          subscription.cancel();
        },
      );
    });

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: _onRefresh, child: widget.child);
  }
}

class _DashboardAppBar extends StatelessWidget {
  const _DashboardAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      toolbarHeight: 80,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Column(
        children: [
          Text(
            "Welcome to Budi Luhur Staff",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          BlocSelector<UserBloc, UserState, String>(
            selector: (state) => state.maybeWhen(
              success: (user) => user.name.isNotEmpty ? user.name : '?',
              orElse: () => '?',
            ),
            builder: (context, userName) {
              return Text(
                userName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
      actions: [
        CircleAvatar(
          radius: 18,
          backgroundColor: Theme.of(
            context,
          ).colorScheme.surfaceContainerHighest,
          foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
          child: Icon(LucideIcons.bell, size: 18),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 12),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Theme.of(
              context,
            ).colorScheme.surfaceContainerHighest,
            foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
            child: BlocSelector<UserBloc, UserState, String>(
              selector: (state) => state.maybeWhen(
                success: (user) =>
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                orElse: () => '?',
              ),
              builder: (context, initial) => Text(initial),
            ),
          ),
        ),
      ],
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Container(
        margin: const EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24),
              child: Text(
                "Dashboard",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _DashboardCheckInOutContainer(
                    title: "Check in",
                    value: "06:45",
                    icon: LucideIcons.squareArrowRight,
                  ),
                  const SizedBox(width: 8),
                  _DashboardCheckInOutContainer(
                    title: "Check out",
                    value: "16:00",
                    icon: LucideIcons.squareArrowLeft,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _TodayStatusCard(),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: _WeeklyActivityChart(
                weeklyData: parseWeeklyData([
                  {
                    "date": "2026-04-06",
                    "check_in": "2026-04-06 07:00:00",
                    "check_out": "2026-04-06 16:00:00",
                    "status": "hadir",
                  },
                  {
                    "date": "2026-04-08",
                    "check_in": null,
                    "check_out": "2026-04-08 16:00:00",
                    "status": "lupa_checkin",
                  },
                  {
                    "date": "2026-04-09",
                    "check_in": "2026-04-09 07:30:00",
                    "check_out": "2026-04-09 16:00:00",
                    "status": "lupa_checkin",
                  },
                  {
                    "date": "2026-04-10",
                    "check_in": "2026-04-10 07:30:00",
                    "check_out": "2026-04-10 16:00:00",
                    "status": "hadir",
                  },
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCheckInOutContainer extends StatelessWidget {
  const _DashboardCheckInOutContainer({
    this.padding,
    this.containerColor,
    this.borderRadius,
    this.border,
    this.title,
    this.value,
    this.icon,
    this.radius,
    this.titleTextColor,
    this.valueTextColor,
    this.circleAvatarBackgroundColor,
    this.circleAvatarForegroundColor,
  });

  final EdgeInsetsGeometry? padding;
  final Color? containerColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final String? title;
  final String? value;
  final IconData? icon;
  final double? radius;
  final Color? titleTextColor;
  final Color? valueTextColor;
  final Color? circleAvatarBackgroundColor;
  final Color? circleAvatarForegroundColor;

  @override
  Widget build(BuildContext context) {
    final containerBackgroundColor =
        containerColor ?? Theme.of(context).colorScheme.surfaceContainer;
    final containerPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    final containerBorderRadius = borderRadius ?? BorderRadius.circular(16);
    final containerBorder =
        border ??
        Border.all(color: Theme.of(context).colorScheme.outlineVariant);
    final titleText = title ?? '-';
    final titleTextStyleFormat = Theme.of(context).textTheme.titleMedium
        ?.copyWith(
          color:
              titleTextColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
        );
    final valueText = value ?? '-';
    final valueTextStyleFormat = Theme.of(context).textTheme.titleLarge
        ?.copyWith(
          color: valueTextColor ?? Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        );
    final radiusAndIconSize = radius ?? 16;
    final avatarBackgroundColor =
        circleAvatarBackgroundColor ??
        Theme.of(context).colorScheme.surfaceContainerHighest;
    final avatarForegroundColor =
        circleAvatarForegroundColor ??
        Theme.of(context).colorScheme.onSurfaceVariant;

    return Expanded(
      child: Container(
        padding: containerPadding,
        decoration: BoxDecoration(
          color: containerBackgroundColor,
          borderRadius: containerBorderRadius,
          border: containerBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(titleText, style: titleTextStyleFormat),
                CircleAvatar(
                  radius: radiusAndIconSize,
                  backgroundColor: avatarBackgroundColor,
                  foregroundColor: avatarForegroundColor,
                  child: Icon(icon, size: radiusAndIconSize),
                ),
              ],
            ),
            Text(valueText, style: valueTextStyleFormat),
          ],
        ),
      ),
    );
  }
}

enum AttendanceStatus { hadir, terlambat, absen }

class _TodayStatusCard extends StatelessWidget {
  const _TodayStatusCard();

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

class _WeeklyActivityChart extends StatelessWidget {
  const _WeeklyActivityChart({required this.weeklyData});

  final List<AttendanceBarData> weeklyData;

  Color _barColor(BuildContext context, String status) {
    switch (status) {
      case 'hadir':
      case 'terlambat':
      case 'lupa_checkout':
      case 'lupa_checkin':
      case 'absen':
        return Theme.of(context).colorScheme.primary;
      default:
        return Theme.of(context).colorScheme.outlineVariant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalHours = weeklyData.fold<double>(
      0,
      (sum, d) => sum + d.hoursWorked,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Weekly",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    // const SizedBox(width: 4),
                    // Icon(
                    //   LucideIcons.chevronDown,
                    //   size: 14,
                    //   color: Theme.of(context).colorScheme.onSurfaceVariant,
                    // ),
                  ],
                ),
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
                maxY: 9,
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
                      final data = weeklyData[groupIndex];
                      final hours = data.hoursWorked.toStringAsFixed(0);
                      return BarTooltipItem(
                        "$hours h",
                        Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.onInverseSurface,
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
                barGroups: List.generate(weeklyData.length, (i) {
                  final data = weeklyData[i];
                  return BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: data.hoursWorked,
                        color: _barColor(context, data.status),
                        width: 20,
                        borderRadius: BorderRadius.circular(12),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 8,
                          color: Theme.of(
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
    );
  }
}
