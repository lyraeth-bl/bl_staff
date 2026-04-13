import 'package:flutter/material.dart';

import '../../../../utils/shared/extension/extension.dart';

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
    this.isLoading = false,
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
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final containerBackgroundColor =
        containerColor ?? colorScheme.surfaceContainer;
    final containerPadding = padding ?? const EdgeInsets.all(12);
    final containerBorderRadius = borderRadius ?? BorderRadius.circular(16);

    final titleText = title ?? '-';
    final titleTextStyleFormat = textTheme.titleMedium?.copyWith(
      color: titleTextColor ?? colorScheme.onSurfaceVariant,
    );
    final valueText = value ?? '-';
    final valueTextStyleFormat = textTheme.titleLarge?.copyWith(
      color: valueTextColor ?? colorScheme.onSurface,
      fontWeight: FontWeight.bold,
    );

    final radiusAndIconSize = radius ?? 16;
    final avatarBackgroundColor =
        circleAvatarBackgroundColor ?? colorScheme.surfaceContainerHighest;
    final avatarForegroundColor =
        circleAvatarForegroundColor ?? colorScheme.onSurfaceVariant;

    return Expanded(
      child: Card.outlined(
        margin: EdgeInsets.zero,
        color: containerBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: containerBorderRadius,
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
        child: Padding(
          padding: containerPadding,
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
              Text(
                valueText,
                style: valueTextStyleFormat,
              ).toShimmer(context, isLoading: isLoading, width: 80, height: 20),
            ].separatedBy(8.h),
          ),
        ),
      ),
    );
  }
}
