import 'package:flutter/material.dart';

import '../../../../utils/shared/extension/extension.dart';

class ProfileList extends StatelessWidget {
  const ProfileList({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.isLoading = false,
  });

  final IconData leading;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      visualDensity: VisualDensity.comfortable,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(leading, color: colorScheme.onSurfaceVariant),
      ),
      title: Text(
        title,
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: textTheme.titleMedium?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ).toShimmer(context, width: 180, height: 16, isLoading: isLoading),
      trailing: (trailing != null) ? trailing! : null,
    );
  }
}
