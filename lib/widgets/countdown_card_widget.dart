import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

class CountdownCard extends StatefulWidget {
  final DateTime targetDate;

  const CountdownCard({super.key, required this.targetDate});

  @override
  State<CountdownCard> createState() => _CountdownCardState();
}

class _CountdownCardState extends State<CountdownCard> {
  late Timer _timer;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _calculateTime();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => _calculateTime(),
    );
  }

  void _calculateTime() {
    final now = DateTime.now();
    setState(() {
      _timeLeft = widget.targetDate.difference(now);
      if (_timeLeft.isNegative) _timeLeft = Duration.zero;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.parchment,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.timer, color: AppColors.crimson),
              SizedBox(width: 8),
              Text(
                "TIEMPO RESTANTE",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.forestDark,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const Divider(color: AppColors.gold),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _TimeBox(value: _timeLeft.inDays, label: "Días"),
              _TimeBox(value: _timeLeft.inHours % 24, label: "Horas"),
              _TimeBox(value: _timeLeft.inMinutes % 60, label: "Min"),
              _TimeBox(
                value: _timeLeft.inSeconds % 60,
                label: "Seg",
                isAccent: true,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.parchmentDark,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: const [
                Text(
                  "Fecha de Inicio",
                  style: TextStyle(fontSize: 12, color: AppColors.forestLight),
                ),
                Text(
                  "13 Diciembre, 2025 - 18:00 hrs",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.crimson,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeBox extends StatelessWidget {
  final int value;
  final String label;
  final bool isAccent;

  const _TimeBox({
    required this.value,
    required this.label,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.forestDark,
            borderRadius: BorderRadius.circular(8),
            border: isAccent
                ? Border.all(color: AppColors.crimson, width: 2)
                : Border.all(color: AppColors.gold),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            style: TextStyle(
              color: isAccent ? AppColors.gold : Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
