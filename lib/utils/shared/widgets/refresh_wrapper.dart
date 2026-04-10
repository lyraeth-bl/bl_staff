import 'dart:async';

import 'package:flutter/material.dart';

/// A widget that wraps a scrollable [child] with a [RefreshIndicator].
///
/// This component provides a standardized way to implement pull-to-refresh
/// behavior, ensuring consistent interaction across the application.
///
/// See also:
/// * [RefreshIndicator], for the standard Material design refresh indicator.
class RefreshWrapper extends StatelessWidget {
  /// Creates a [RefreshWrapper].
  const RefreshWrapper({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  /// The callback invoked when the user triggers a refresh.
  final Future<void> Function() onRefresh;

  /// The scrollable widget that can be pulled down to refresh.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: onRefresh, child: child);
  }
}
