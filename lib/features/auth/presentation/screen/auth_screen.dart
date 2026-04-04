import 'package:bl_staff/bl_staff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          successLogin: (accessToken, _) {
            context.read<SessionsBloc>().add(
              SessionsEvent.loggedIn(token: accessToken),
            );
          },
        );
      },
      child: Scaffold(
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
                const SizedBox(height: 32),
                _TroubleLogInText(),
              ],
            ),
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginStaff() {
    context.read<AuthBloc>().add(
      AuthEvent.loginRequested(
        loginParams: LoginParams(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthTextField(
          textEditingController: _emailController,
          hintText: "Username / Email",
        ),
        const SizedBox(height: 24),
        AuthTextField(
          textEditingController: _passwordController,
          hintText: "Password",
          obscureText: true,
        ),
        const SizedBox(height: 8),
        _RememberMeRow(),
        const SizedBox(height: 40),
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            final isLoading = state.maybeWhen(
              loading: () => true,
              orElse: () => false,
            );

            return isLoading
                ? AuthActionButtons(
                    buttonColor: isLoading
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.primary,
                    actionWidget: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onPrimary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.secondaryContainer,
                      ),
                    ),
                  )
                : AuthActionButtons(
                    actionWidget: Text(
                      "Login",
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    actionOnTap: () {
                      if (isLoading) return;

                      _loginStaff();
                    },
                  );
          },
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
