import 'package:bl_staff/core/app_router/app_router.dart';
import 'package:bl_staff/utils/shared/constant.dart';
import 'package:flutter/material.dart';

class BlStaffApp extends StatelessWidget {
  const BlStaffApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: getIt<AppRouter>().goRouter);
  }
}
