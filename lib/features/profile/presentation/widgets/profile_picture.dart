import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.userName,
    this.radius,
    this.inverseColor = false,
    this.reverseColor = false,
  }) : assert(
         !(inverseColor && reverseColor),
         'inverseColor dan reverseColor cannot both be true at the same time',
       );

  final String userName;
  final double? radius;
  final bool inverseColor;
  final bool reverseColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = inverseColor
        ? colorScheme.onInverseSurface
        : reverseColor
        ? colorScheme.inverseSurface
        : colorScheme.surfaceContainerHighest;

    final foregroundColor = inverseColor
        ? colorScheme.inverseSurface
        : reverseColor
        ? colorScheme.onInverseSurface
        : colorScheme.onSurfaceVariant;

    return CircleAvatar(
      radius: radius ?? 24,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      child: Text(userName[0], style: TextStyle(fontSize: radius)),
    );
  }
}
