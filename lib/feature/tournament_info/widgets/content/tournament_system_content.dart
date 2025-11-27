import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

class TournamentSystemContent extends StatelessWidget {
  const TournamentSystemContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Sistema de Torneo',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }
}
