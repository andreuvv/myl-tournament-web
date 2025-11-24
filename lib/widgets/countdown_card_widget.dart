import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/controllers/countdown_controller.dart';

class CountdownCard extends StatefulWidget {
  final DateTime targetDate;

  const CountdownCard({super.key, required this.targetDate});

  @override
  State<CountdownCard> createState() => _CountdownCardState();
}

class _CountdownCardState extends State<CountdownCard> {
  late CountdownController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CountdownController(widget.targetDate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: _controller.timeStream,
      initialData: _controller.initialTime,
      builder: (context, snapshot) {
        final timeLeft = snapshot.data ?? Duration.zero;

        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.beige,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.ocher, width: 2),
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
                  Icon(Icons.timer, color: AppColors.brickRed),
                  SizedBox(width: 8),
                  Text(
                    "TIEMPO RESTANTE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.coalGrey,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
              const Divider(color: AppColors.ocher),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _TimeBox(value: timeLeft.inDays, label: "Días"),
                  _TimeBox(value: timeLeft.inHours % 24, label: "Horas"),
                  _TimeBox(value: timeLeft.inMinutes % 60, label: "Min"),
                  _TimeBox(
                    value: timeLeft.inSeconds % 60,
                    label: "Seg",
                    isAccent: true,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: const [
                    Text(
                      "Fecha de Inicio",
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.coalGrey,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "13 Diciembre, 2025 - 18:00 hrs",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.petrolBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
            color: AppColors.sageGreen,
            borderRadius: BorderRadius.circular(8),
            border: isAccent
                ? Border.all(color: AppColors.brickRed, width: 2)
                : Border.all(color: AppColors.ocher),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            style: TextStyle(
              color: isAccent ? AppColors.coalGrey : Colors.white,
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
