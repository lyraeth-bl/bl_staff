import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.userName,
    this.radius,
    this.inverseColor = false,
  });

  final String userName;
  final double? radius;
  final bool inverseColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = inverseColor
        ? colorScheme.onInverseSurface
        : colorScheme.surfaceContainerHighest;

    final foregroundColor = inverseColor
        ? colorScheme.inverseSurface
        : colorScheme.onSurfaceVariant;

    return CircleAvatar(
      radius: radius ?? 24,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      child: Text(userName[0], style: TextStyle(fontSize: radius)),
    );
  }
}
