import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_conf_web/core/constants/constants.dart';
import 'package:flutter_conf_web/l10n/l10n.dart';
import 'package:google_fonts/google_fonts.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime eventDate;

  const CountdownTimer({
    super.key,
    required this.eventDate,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Duration _timeLeft = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _calculateTimeLeft();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateTimeLeft();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateTimeLeft() {
    final now = DateTime.now();
    final difference = widget.eventDate.difference(now);

    if (mounted) {
      setState(() {
        _timeLeft = difference.isNegative ? Duration.zero : difference;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = MediaQuery.of(context).size;
    final days = _timeLeft.inDays;
    final hours = _timeLeft.inHours % 24;
    final minutes = _timeLeft.inMinutes % 60;
    final seconds = _timeLeft.inSeconds % 60;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width > kBreakPoint ? 60 : 30,
        vertical: size.width > kBreakPoint ? 40 : 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: size.width > kBreakPoint
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _CountdownUnit(
                  value: days.toString().padLeft(2, '0'),
                  label: l10n.days,
                ),
                const SizedBox(width: 40),
                _CountdownUnit(
                  value: hours.toString().padLeft(2, '0'),
                  label: l10n.hours,
                ),
                const SizedBox(width: 40),
                _CountdownUnit(
                  value: minutes.toString().padLeft(2, '0'),
                  label: l10n.minutes,
                ),
                const SizedBox(width: 40),
                _CountdownUnit(
                  value: seconds.toString().padLeft(2, '0'),
                  label: l10n.seconds,
                ),
              ],
            )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CountdownUnit(
                      value: days.toString().padLeft(2, '0'),
                      label: l10n.days,
                    ),
                    _CountdownUnit(
                      value: hours.toString().padLeft(2, '0'),
                      label: l10n.hours,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _CountdownUnit(
                      value: minutes.toString().padLeft(2, '0'),
                      label: l10n.minutes,
                    ),
                    _CountdownUnit(
                      value: seconds.toString().padLeft(2, '0'),
                      label: l10n.seconds,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class _CountdownUnit extends StatelessWidget {
  final String value;
  final String label;

  const _CountdownUnit({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2C3E50),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF2C3E50),
          ),
        ),
      ],
    );
  }
}
