import 'package:bl_staff/bl_staff.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () => context.go(RouteNames.authLogin),
          child: Text("Ke Auth Login"),
        ),
      ),
    );
  }
}
