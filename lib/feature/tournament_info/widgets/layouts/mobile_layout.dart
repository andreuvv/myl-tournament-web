import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import '../../models/info_section.dart';
import '../../models/tournament_subsection.dart';
import '../../controllers/tournament_info_controller.dart';
import '../content/general_info_content.dart';
import '../content/tournament_system_content.dart';
import '../content/prizes_and_funding_content.dart';
import '../content/participants_content.dart';
import '../content/schedule_content.dart';
import '../content/subsection_content.dart';

class MobileLayout extends StatelessWidget {
  final InfoSection selectedSection;
  final TournamentSubsection? selectedSubsection;
  final TournamentInfoController controller;

  const MobileLayout({
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
      case InfoSection.general:
        return const GeneralInfoContent();
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
    final currentTitle = selectedSubsection?.title ?? selectedSection.title;

    return Column(
      children: [
        // Fixed header with title and menu
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: AppColors.coalGrey,
          ),
          child: Row(
            children: [
              PopupMenuButton<dynamic>(
                icon: const Icon(Icons.menu, color: AppColors.beige),
                color: AppColors.coalGrey,
                onSelected: (value) {
                  if (value is InfoSection) {
                    controller.selectSection(value);
                  } else if (value is TournamentSubsection) {
                    controller.selectSubsection(
                        value, InfoSection.tournamentSystem);
                  }
                },
                itemBuilder: (context) {
                  List<PopupMenuEntry<dynamic>> items = [];
                  for (var section in InfoSection.values) {
                    // Add section item
                    items.add(
                      PopupMenuItem(
                        value: section,
                        child: Row(
                          children: [
                            Icon(section.icon,
                                color: AppColors.beige, size: 18),
                            const SizedBox(width: 12),
                            Text(
                              section.title,
                              style: const TextStyle(
                                color: AppColors.beige,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    // Add subsection items if they exist
                    if (section.subsections != null) {
                      for (var subsection in section.subsections!) {
                        items.add(
                          PopupMenuItem(
                            value: subsection,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Text(
                                subsection.title,
                                style: TextStyle(
                                  color: AppColors.beige.withValues(alpha: 0.9),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    // Add divider between sections (except after last)
                    if (section != InfoSection.values.last) {
                      items.add(const PopupMenuDivider());
                    }
                  }
                  return items;
                },
              ),
              Expanded(
                child: Text(
                  currentTitle,
                  style: const TextStyle(
                    color: AppColors.beige,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Content area
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
