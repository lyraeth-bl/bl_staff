import 'package:bl_staff/bl_staff.dart';
import 'package:flutter/material.dart';

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
