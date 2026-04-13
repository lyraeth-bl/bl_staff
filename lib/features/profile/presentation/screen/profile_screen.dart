import 'package:bl_staff/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/core.dart';
import '../../../../utils/utils_export.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _ProfileRefreshWrapper(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            successLogout: () =>
                context.read<SessionsBloc>().add(SessionsEvent.loggedOut()),
          );
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          body: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [_ProfileAppBar(), _ProfileContent()],
          ),
        ),
      ),
    );
  }
}

class _ProfileRefreshWrapper extends StatelessWidget {
  const _ProfileRefreshWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshWrapper(
      onRefresh: () => blocRefresh<UserBloc, UserEvent, UserState>(
        context: context,
        event: const UserEvent.fetchUser(forceRefresh: true),
        isDone: (state) => state.maybeWhen(
          success: (_) => true,
          failure: (_, _) => true,
          orElse: () => false,
        ),
      ),
      child: child,
    );
  }
}

class _ProfileAppBar extends StatelessWidget {
  const _ProfileAppBar();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      pinned: false,
      floating: false,
      toolbarHeight: 80,
      backgroundColor: colorScheme.surfaceContainer,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      title: Text(
        "My profile",
        style: textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ProfileContent extends StatelessWidget {
  const _ProfileContent();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(top: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _UserDataContainer(),
            _UserBasicInformationContainer(),
            ProfileLogoutButton(
              onTap: () {
                context.read<AuthBloc>().add(AuthEvent.logoutRequested());
              },
            ),
          ].separatedBy(32.h),
        ),
      ),
    );
  }
}

class _UserDataContainer extends StatelessWidget {
  const _UserDataContainer();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.inverseSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (failure, _) {
              toastification.show(
                context: context,
                autoCloseDuration: const Duration(seconds: 3),
                type: ToastificationType.error,
                style: ToastificationStyle.flat,
                title: Text(failure.displayMessage),
                alignment: Alignment.bottomCenter,
              );
            },
          );
        },
        builder: (context, state) {
          final UserEntity? user = state.whenOrNull(
            success: (user) => user,
            failure: (_, lastUserData) => lastUserData,
          );

          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfilePicture(
                radius: 40,
                userName: user?.name ?? "-",
                inverseColor: true,
              ),
              Text(
                user?.name ?? "-",
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onInverseSurface,
                  fontWeight: FontWeight.bold,
                ),
              ).toShimmer(
                context,
                width: 210,
                height: 16,
                isLoading: isLoading,
                alignment: Alignment.center,
              ),
              Text(
                user?.email ?? "-",
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onInverseSurface,
                ),
              ).toShimmer(
                context,
                width: 120,
                height: 16,
                isLoading: isLoading,
                alignment: Alignment.center,
              ),
            ].separatedBy(24.h),
          );
        },
      ),
    );
  }
}

class _UserBasicInformationContainer extends StatelessWidget {
  const _UserBasicInformationContainer();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Basic information",
          style: textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              final isLoading = state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              );

              return Column(
                children: [
                  ProfileList(
                    leading: LucideIcons.school,
                    title: "Department",
                    subtitle: "SMA Budi Luhur Karang Tengah",
                    isLoading: isLoading,
                  ),
                  ProfileList(
                    leading: LucideIcons.bookUser,
                    title: "Phone number",
                    subtitle: "+6285719621252",
                    isLoading: isLoading,
                  ),
                  ProfileList(
                    leading: LucideIcons.briefcase,
                    title: "Position",
                    subtitle: "IT Staff",
                    isLoading: isLoading,
                  ),
                  ProfileList(
                    leading: LucideIcons.userKey,
                    title: "Leader",
                    subtitle: "Ridwan",
                    isLoading: isLoading,
                  ),
                ],
              );
            },
          ),
        ),
      ].separatedBy(24.h),
    );
  }
}
