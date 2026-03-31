import 'package:bl_staff/core/di/setup_locator.dart';
import 'package:flutter/material.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();
}
