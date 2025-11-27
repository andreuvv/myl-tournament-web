import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

class PrizesAndFundingContent extends StatelessWidget {
  const PrizesAndFundingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Premios y Financiamiento',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }
}
