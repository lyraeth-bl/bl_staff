import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AuthActionButtons extends StatelessWidget {
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

  final void Function()? actionOnTap;
  final void Function()? secondActionOnTap;
  final bool? addSecondAction;
  final BorderRadiusGeometry? actionBorderRadius;
  final BorderRadiusGeometry? secondActionBorderRadius;
  final EdgeInsetsGeometry? actionPadding;
  final EdgeInsetsGeometry? secondActionPadding;
  final Widget actionWidget;
  final Widget? secondActionWidget;
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
