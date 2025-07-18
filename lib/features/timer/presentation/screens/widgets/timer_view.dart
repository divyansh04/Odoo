import 'dart:async';
import 'package:flutter/material.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';

class TimerView extends StatefulWidget {
  final TimerEntry timer;
  final TextStyle? style;

  const TimerView({super.key, required this.timer, this.style});

  // Helper for static formatting
  static String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    if (widget.timer.isRunning) {
      _startTicker();
    }
  }

  @override
  void didUpdateWidget(covariant TimerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.timer.isRunning && !_isTickerActive) {
      _startTicker();
    } else if (!widget.timer.isRunning && _isTickerActive) {
      _stopTicker();
    }
  }

  void _startTicker() {
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  bool get _isTickerActive => _ticker?.isActive ?? false;

  @override
  void dispose() {
    _stopTicker();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = widget.timer.totalDuration;
    final formattedDuration = TimerView.formatDuration(duration);
    return Text(formattedDuration, style: widget.style);
  }
}
