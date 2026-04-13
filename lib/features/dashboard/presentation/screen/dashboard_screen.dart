import 'package:bl_staff/utils/utils_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/bloc/bloc_refresh_helper.dart';
import '../../../attendance/attendance.dart';
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
    context.read<TodayAttendanceCubit>().load();
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

class _DashboardRefreshWrapper extends StatelessWidget {
  const _DashboardRefreshWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshWrapper(
      onRefresh: () => Future.wait([
        blocRefresh<UserBloc, UserEvent, UserState>(
          context: context,
          event: const UserEvent.fetchUser(forceRefresh: true),
          isDone: (state) => state.maybeWhen(
            success: (_) => true,
            failure: (_) => true,
            orElse: () => false,
          ),
        ),
        cubitRefresh<TodayAttendanceCubit, TodayAttendanceState>(
          context: context,
          trigger: (cubit) => cubit.refresh(),
          isDone: (state) => state.maybeWhen(
            success: (_) => true,
            noAttendanceToday: () => true,
            failure: (_) => true,
            orElse: () => false,
          ),
        ),
        blocRefresh<AttendanceBloc, AttendanceEvent, AttendanceState>(
          context: context,
          event: const AttendanceEvent.refreshed(),
          isDone: (state) => state.maybeWhen(
            success: (_, _, _) => true,
            failure: (_) => true,
            orElse: () => false,
          ),
        ),
      ]),
      child: child,
    );
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
      surfaceTintColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      scrolledUnderElevation: 4.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to Budi Luhur Staff",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          _UserNameOnAppBar(),
        ].separatedBy(4.h),
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

            24.h,

            BlocBuilder<TodayAttendanceCubit, TodayAttendanceState>(
              builder: (context, state) {
                final todayAttendance = state.whenOrNull(
                  success: (attendance) => attendance,
                );

                final isLoading = state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                );

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          CheckinCheckoutContainer(
                            title: "Check in",
                            value: todayAttendance?.checkIn?.toHourMinuteFormat,
                            icon: LucideIcons.squareArrowRight,
                            isLoading: isLoading,
                          ),
                          const SizedBox(width: 8),
                          CheckinCheckoutContainer(
                            title: "Check out",
                            value:
                                todayAttendance?.checkOut?.toHourMinuteFormat,
                            icon: LucideIcons.squareArrowLeft,
                            isLoading: isLoading,
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: state.when(
                        initial: () => const SizedBox.shrink(),
                        loading: () => const TodayStatusCardShimmer(),

                        noAttendanceToday: () => TodayStatusCard(
                          status: AttendanceStatus.belumAbsen,
                        ),

                        success: (attendance) {
                          final status = attendance!.status;
                          return TodayStatusCard(status: status);
                        },

                        failure: (failure) {
                          toastification.show(
                            context: context,
                            autoCloseDuration: const Duration(seconds: 3),
                            type: ToastificationType.error,
                            style: ToastificationStyle.flat,
                            title: Text(failure.displayMessage),
                            alignment: Alignment.bottomCenter,
                          );

                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ].separatedBy(8.h),
                );
              },
            ),

            8.h,

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
                  final List<AttendanceEntity> attendanceData = state.maybeWhen(
                    success: (attendances, _, _) => attendances,
                    orElse: () => [],
                  );

                  return WeeklyActivityChart(
                    weeklyData: parseWeeklyData(attendanceData),
                  );
                },
              ),
            ),
          ].makeListAnimate(),
        ),
      ),
    );
  }
}

class _UserNameOnAppBar extends StatelessWidget {
  const _UserNameOnAppBar();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final bool isLoading = state.maybeWhen(
          loading: () => true,
          orElse: () => false,
        );

        final userName = state.maybeWhen(
          success: (user) => user.name.isNotEmpty ? user.name : '-',
          orElse: () => '-',
        );

        return Text(
          userName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ).toShimmer(context, isLoading: isLoading, width: 160, height: 16);
      },
    );
  }
}
