import 'package:bl_staff/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../../../sessions/sessions.dart';
import '../../domain/entities/login_params/login_params.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/remember_me/remember_me_cubit.dart';
import '../widgets/auth_action_buttons.dart';
import '../widgets/auth_text_field.dart';

/// The primary screen for user authentication.
///
/// This screen provides the interface for users to enter their credentials,
/// manages login state transitions, and navigates to other parts of the app
/// upon successful authentication.
class AuthScreen extends StatelessWidget {
  /// Creates an [AuthScreen].
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
                const _LoginForm(),
                const SizedBox(height: 32),
                const _TroubleLogInText(),
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

  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<RememberMeCubit>().loadSavedEmail();
      getSavedEmail();
    });
  }

  void getSavedEmail() {
    final savedEmail = context.read<RememberMeCubit>().state.savedEmail;
    if (savedEmail.isNotEmpty) {
      _emailController.text = savedEmail;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginStaff() {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    context.read<AuthBloc>().add(
      AuthEvent.loginRequested(
        loginParams: LoginParams(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      ),
    );
  }

  void _handleFailure(Failure failure) {
    failure.maybeMap(
      validation: (f) {
        setState(() {
          _emailError = f.errors['email']?.firstOrNull;
          _passwordError = f.errors['password']?.firstOrNull;
        });
      },
      orElse: () {
        toastification.show(
          context: context,
          autoCloseDuration: const Duration(seconds: 5),
          type: ToastificationType.error,
          style: ToastificationStyle.flat,
          title: Text(failure.displayMessage),
          alignment: Alignment.bottomCenter,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          successLogin: (_, _) {
            context.read<RememberMeCubit>().onLoginSuccess(
              _emailController.text.trim(),
            );
          },
          failure: (failure) => _handleFailure(failure),
        );
      },
      child: Column(
        children: [
          AuthTextField(
            textEditingController: _emailController,
            hintText: "Email",
            errorText: _emailError,
            onChanged: () {
              setState(() => _emailError = null);
            },
          ),
          const SizedBox(height: 24),
          AuthTextField(
            textEditingController: _passwordController,
            hintText: "Password",
            obscureText: true,
            errorText: _passwordError,
            onChanged: () {
              setState(() => _passwordError = null);
            },
          ),
          const SizedBox(height: 8),
          const _RememberMeRow(),
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

                        FocusScope.of(context).unfocus();

                        _loginStaff();
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}

class _RememberMeRow extends StatefulWidget {
  const _RememberMeRow();

  @override
  State<_RememberMeRow> createState() => _RememberMeRowState();
}

class _RememberMeRowState extends State<_RememberMeRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            BlocBuilder<RememberMeCubit, RememberMeState>(
              builder: (context, state) {
                return Checkbox(
                  value: state.isChecked,
                  onChanged: (value) {
                    context.read<RememberMeCubit>().toggleCheckBox(
                      value ?? false,
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(16),
                  ),
                );
              },
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
