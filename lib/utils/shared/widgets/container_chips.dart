import 'package:flutter/material.dart';

class ContainerChips extends StatelessWidget {
  const ContainerChips({
    super.key,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.enableBorder = true,
    this.padding,
    this.style,
  }) : assert(
         style != null || foregroundColor != null,
         'foregroundColor cannot be used with style',
       );

  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool enableBorder;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final containerColor =
        backgroundColor ?? Theme.of(context).colorScheme.surface;
    final textColor =
        foregroundColor ?? Theme.of(context).colorScheme.onSurface;

    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
        border: (enableBorder)
            ? Border.all(color: Theme.of(context).colorScheme.outlineVariant)
            : null,
      ),
      child: Text(
        text,
        style:
            style ??
            Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
      ),
    );
  }
}
