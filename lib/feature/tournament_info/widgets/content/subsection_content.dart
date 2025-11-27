import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/feature/tournament_info/models/tournament_subsection.dart';

class SubsectionContent extends StatelessWidget {
  final TournamentSubsection subsection;

  const SubsectionContent({
    super.key,
    required this.subsection,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        subsection.title,
        style: const TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }
}
