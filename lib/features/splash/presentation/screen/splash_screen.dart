import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/core.dart';
import '../../../../utils/shared/extension/extension.dart';
import '../../../sessions/sessions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        if (!mounted) return;

        _sessionEventStarted();
      });
    });
  }

  void _sessionEventStarted() {
    context.read<SessionsBloc>().add(const SessionsEvent.started());
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<SessionsBloc, SessionsState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (_) => context.go(RouteNames.dashboard),
          unauthenticated: () => context.go(RouteNames.authLogin),
        );
      },
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                [
                      Container(
                        width: 225,
                        height: 225,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset("assets/images/bl_logo.png"),
                      ),

                      32.h,

                      Text(
                        "Budi Luhur Staff",
                        style: textTheme.headlineMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),

                      8.h,

                      Text(
                        "Loading your workspace...",
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),

                      48.h,

                      SizedBox(
                        width: 200,
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(8),
                          backgroundColor: colorScheme.surfaceContainerHighest,
                          color: colorScheme.primary,
                        ),
                      ),
                    ]
                    .animate(interval: 100.ms)
                    .fadeIn(duration: 800.ms, curve: Curves.easeOut)
                    .slideY(
                      begin: 0.1,
                      end: 0,
                      duration: 800.ms,
                      curve: Curves.easeOut,
                    ),
          ),
        ),
      ),
    );
  }
}
