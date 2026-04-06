import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils_export.dart';
import '../../features/features.dart';

class AppBlocProvider extends StatelessWidget {
  const AppBlocProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SessionsBloc>.value(value: getIt<SessionsBloc>()),
        BlocProvider<AuthBloc>.value(value: getIt<AuthBloc>()),
        BlocProvider<RememberMeCubit>.value(value: getIt<RememberMeCubit>()),
        BlocProvider<UserBloc>.value(value: getIt<UserBloc>()),
      ],
      child: child,
    );
  }
}
