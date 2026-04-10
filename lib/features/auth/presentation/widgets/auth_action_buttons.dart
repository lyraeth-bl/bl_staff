import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

/// A layout widget that displays primary and optional secondary action buttons.
///
/// This widget is typically used in authentication screens to provide a main
/// call-to-action (like login) and an optional secondary action (like biometric
/// authentication). It handles the layout and styling of these buttons.
class AuthActionButtons extends StatelessWidget {
  /// Creates an [AuthActionButtons] with the given actions and widgets.
  const AuthActionButtons({
    super.key,
    this.actionOnTap,
    this.secondActionOnTap,
    this.addSecondAction = false,
    this.actionBorderRadius,
    this.secondActionBorderRadius,
    this.actionPadding,
    this.secondActionPadding,
    required this.actionWidget,
    this.secondActionWidget,
    this.buttonColor,
  });

  /// The callback that is called when the primary action button is tapped.
  final void Function()? actionOnTap;

  /// The callback that is called when the secondary action button is tapped.
  final void Function()? secondActionOnTap;

  /// Whether to display the secondary action button.
  final bool? addSecondAction;

  /// The border radius of the primary action button.
  final BorderRadiusGeometry? actionBorderRadius;

  /// The border radius of the secondary action button.
  final BorderRadiusGeometry? secondActionBorderRadius;

  /// The padding of the primary action button.
  final EdgeInsetsGeometry? actionPadding;

  /// The padding of the secondary action button.
  final EdgeInsetsGeometry? secondActionPadding;

  /// The widget to display inside the primary action button.
  final Widget actionWidget;

  /// The widget to display inside the secondary action button.
  final Widget? secondActionWidget;

  /// The background color of the primary action button.
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              actionOnTap?.call();
            },
            child: Container(
              padding:
                  actionPadding ?? const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: actionBorderRadius ?? BorderRadius.circular(16),
                color: buttonColor ?? Theme.of(context).colorScheme.primary,
              ),
              child: Center(child: actionWidget),
            ),
          ),
        ),
        if (addSecondAction != false) ...[
          GestureDetector(
            onTap: () {
              secondActionOnTap?.call();
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: secondActionPadding ?? const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius:
                    secondActionBorderRadius ?? BorderRadius.circular(16),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Center(
                child:
                    secondActionWidget ??
                    Icon(
                      LucideIcons.fingerprint,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
