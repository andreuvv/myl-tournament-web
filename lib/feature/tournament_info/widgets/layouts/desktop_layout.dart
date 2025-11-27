import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/feature/tournament_info/models/info_section.dart';
import 'package:myl_app_web/feature/tournament_info/models/tournament_subsection.dart';
import 'package:myl_app_web/feature/tournament_info/controllers/tournament_info_controller.dart';
import 'package:myl_app_web/feature/tournament_info/widgets/index_item_widget.dart';
import 'package:myl_app_web/feature/tournament_info/widgets/content/general_info_content.dart';
import 'package:myl_app_web/feature/tournament_info/widgets/content/tournament_system_content.dart';
import 'package:myl_app_web/feature/tournament_info/widgets/content/prizes_and_funding_content.dart';
import 'package:myl_app_web/feature/tournament_info/widgets/content/participants_content.dart';
import 'package:myl_app_web/feature/tournament_info/widgets/content/schedule_content.dart';
import 'package:myl_app_web/feature/tournament_info/widgets/content/subsection_content.dart';

class DesktopLayout extends StatelessWidget {
  final InfoSection selectedSection;
  final TournamentSubsection? selectedSubsection;
  final TournamentInfoController controller;

  const DesktopLayout({
    super.key,
    required this.selectedSection,
    required this.selectedSubsection,
    required this.controller,
  });

  Widget _buildContent() {
    if (selectedSubsection != null) {
      return SubsectionContent(subsection: selectedSubsection!);
    }

    switch (selectedSection) {
      // case InfoSection.general:
      //   return const GeneralInfoContent();
      case InfoSection.tournamentSystem:
        return const TournamentSystemContent();
      case InfoSection.prizesAndFunding:
        return const PrizesAndFundingContent();
      case InfoSection.participants:
        return const ParticipantsContent();
      case InfoSection.schedule:
        return const ScheduleContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left sidebar - 1/4 of screen
        Container(
          width: MediaQuery.of(context).size.width / 4,
          color: AppColors.coalGrey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: InfoSection.values.map((section) {
              return IndexItemWidget(
                section: section,
                selectedSection: selectedSection,
                selectedSubsection: selectedSubsection,
                controller: controller,
              );
            }).toList(),
          ),
        ),
        // Right content - 3/4 of screen
        Expanded(
          child: Container(
            color: AppColors.coalGrey,
            child: _buildContent(),
          ),
        ),
      ],
    );
  }
}
