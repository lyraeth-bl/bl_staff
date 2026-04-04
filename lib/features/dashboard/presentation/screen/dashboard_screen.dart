import 'package:bl_staff/bl_staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<SessionsBloc, SessionsState>(
          builder: (context, state) {
            return state.maybeWhen(
              authenticated: (accessToken) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(accessToken),
                  const SizedBox(height: 24),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      state.whenOrNull(
                        successLogout: () => context.read<SessionsBloc>().add(
                          SessionsEvent.loggedOut(),
                        ),
                      );
                    },
                    child: FilledButton.tonal(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                          AuthEvent.logoutRequested(),
                        );
                      },
                      child: Text("Logout"),
                    ),
                  ),
                ],
              ),
              orElse: () => Text("Tidak ada token"),
            );
          },
        ),
      ),
    );
  }
}
