import 'package:bl_staff/features/auth/presentation/widgets/auth_action_buttons.dart';
import 'package:bl_staff/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(40, 80, 40, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hey, \nLogin Now.",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 40),
              _LoginForm(),
              const SizedBox(height: 8),
              _RememberMeRow(),
              const SizedBox(height: 40),
              AuthActionButtons(
                actionWidget: Text(
                  "Login",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _TroubleLogInText(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthTextField(
          textEditingController: _usernameController,
          hintText: "Username / Email",
        ),
        const SizedBox(height: 24),
        AuthTextField(
          textEditingController: _passwordController,
          hintText: "Password",
          obscureText: true,
        ),
      ],
    );
  }
}

class _RememberMeRow extends StatefulWidget {
  const _RememberMeRow();

  @override
  State<_RememberMeRow> createState() => _RememberMeRowState();
}

class _RememberMeRowState extends State<_RememberMeRow> {
  bool _valueCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: _valueCheckBox,
              onChanged: (bool? value) {
                setState(() {
                  _valueCheckBox = value ?? false;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
            ),
            Text(
              "Remember me?",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            "Forget password?",
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _TroubleLogInText extends StatelessWidget {
  const _TroubleLogInText();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Having any trouble logging in?",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          // TODO : Contact Us.
          onTap: () {},
          child: Text(
            "Contact us.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
