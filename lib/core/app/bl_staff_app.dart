import 'package:flutter/material.dart';

import '../../../utils/utils_export.dart';
import '../app_router/app_router.dart';
import '../theme/theme.dart';
import 'app_bloc_provider.dart';

class BlStaffApp extends StatelessWidget {
  const BlStaffApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBlocProvider(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: getIt<AppRouter>().goRouter,
        themeMode: ThemeMode.system,
        theme: lightMode,
        darkTheme: darkMode,
      ),
    );
  }
}
