import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

class ScheduleContent extends StatelessWidget {
  const ScheduleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Cronograma',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }
}
