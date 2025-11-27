import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

class GeneralInfoContent extends StatelessWidget {
  const GeneralInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Información General del Torneo',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }
}
