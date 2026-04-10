import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../utils/utils_export.dart';

/// A widget that displays the current time and updates every second.
///
/// This clock is lifecycle-aware; it stops updating when the app is in the
/// background to save resources and resumes when the app returns to the
/// foreground.
class RealTimeClock extends StatefulWidget {
  /// Creates a [RealTimeClock].
  const RealTimeClock({super.key, this.style});

  /// The text style to apply to the clock display.
  final TextStyle? style;

  @override
  State<RealTimeClock> createState() => _RealTimeClockState();
}

class _RealTimeClockState extends State<RealTimeClock>
    with WidgetsBindingObserver {
  late Timer _timer;
  DateTime _now = DateTime.now();
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isActive) return;
      if (!mounted) return;
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _isActive = false;
    } else if (state == AppLifecycleState.resumed) {
      _isActive = true;
      if (mounted) {
        setState(() => _now = DateTime.now());
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Center(
        child: Text(_now.toHourMinuteSecondFormat, style: widget.style),
      ),
    );
  }
}
