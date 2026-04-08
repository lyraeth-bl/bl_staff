import 'package:flutter/material.dart';

class ContainerChips extends StatelessWidget {
  const ContainerChips({
    super.key,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final containerColor =
        backgroundColor ?? Theme.of(context).colorScheme.surface;
    final textColor =
        foregroundColor ?? Theme.of(context).colorScheme.onSurface;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: textColor),
      ),
    );
  }
}
