import 'package:bl_staff/bl_staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocProvider extends StatelessWidget {
  const AppBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionsBloc>.value(value: getIt<SessionsBloc>()),
        BlocProvider<AuthBloc>.value(value: getIt<AuthBloc>()),
      ],
      child: child,
    );
  }
}
