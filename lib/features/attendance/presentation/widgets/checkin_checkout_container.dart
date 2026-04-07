import 'package:flutter/material.dart';

class CheckinCheckoutContainer extends StatelessWidget {
  const CheckinCheckoutContainer({
    super.key,
    this.padding,
    this.containerColor,
    this.borderRadius,
    this.border,
    this.title,
    this.value,
    this.icon,
    this.radius,
    this.titleTextColor,
    this.valueTextColor,
    this.circleAvatarBackgroundColor,
    this.circleAvatarForegroundColor,
  });

  final EdgeInsetsGeometry? padding;
  final Color? containerColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final String? title;
  final String? value;
  final IconData? icon;
  final double? radius;
  final Color? titleTextColor;
  final Color? valueTextColor;
  final Color? circleAvatarBackgroundColor;
  final Color? circleAvatarForegroundColor;

  @override
  Widget build(BuildContext context) {
    final containerBackgroundColor =
        containerColor ?? Theme.of(context).colorScheme.surfaceContainer;
    final containerPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
    final containerBorderRadius = borderRadius ?? BorderRadius.circular(16);
    final containerBorder =
        border ??
        Border.all(color: Theme.of(context).colorScheme.outlineVariant);
    final titleText = title ?? '-';
    final titleTextStyleFormat = Theme.of(context).textTheme.titleMedium
        ?.copyWith(
          color:
              titleTextColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
        );
    final valueText = value ?? '-';
    final valueTextStyleFormat = Theme.of(context).textTheme.titleLarge
        ?.copyWith(
          color: valueTextColor ?? Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        );
    final radiusAndIconSize = radius ?? 16;
    final avatarBackgroundColor =
        circleAvatarBackgroundColor ??
        Theme.of(context).colorScheme.surfaceContainerHighest;
    final avatarForegroundColor =
        circleAvatarForegroundColor ??
        Theme.of(context).colorScheme.onSurfaceVariant;

    return Expanded(
      child: Container(
        padding: containerPadding,
        decoration: BoxDecoration(
          color: containerBackgroundColor,
          borderRadius: containerBorderRadius,
          border: containerBorder,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(titleText, style: titleTextStyleFormat),
                CircleAvatar(
                  radius: radiusAndIconSize,
                  backgroundColor: avatarBackgroundColor,
                  foregroundColor: avatarForegroundColor,
                  child: Icon(icon, size: radiusAndIconSize),
                ),
              ],
            ),
            Text(valueText, style: valueTextStyleFormat),
          ],
        ),
      ),
    );
  }
}
