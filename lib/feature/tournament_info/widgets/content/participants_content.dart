import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

class ParticipantsContent extends StatelessWidget {
  const ParticipantsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Participantes',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }
}
