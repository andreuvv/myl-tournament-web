import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/feature/tournament_info/controllers/tournament_info_controller.dart';
import 'package:myl_app_web/feature/tournament_info/models/info_section.dart';
import 'package:myl_app_web/feature/tournament_info/models/tournament_subsection.dart';

class IndexItemWidget extends StatelessWidget {
  final InfoSection section;
  final InfoSection selectedSection;
  final TournamentSubsection? selectedSubsection;
  final TournamentInfoController controller;

  const IndexItemWidget({
    super.key,
    required this.section,
    required this.selectedSection,
    required this.selectedSubsection,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isSectionSelected = selectedSection == section;
    final subsections = section.subsections;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main section item
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => controller.selectSection(section),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isSectionSelected && selectedSubsection == null
                    ? AppColors.petrolBlue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSectionSelected && selectedSubsection == null
                      ? AppColors.ocher
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    section.icon,
                    color: AppColors.beige,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      section.title,
                      style: TextStyle(
                        color: AppColors.beige,
                        fontWeight:
                            isSectionSelected && selectedSubsection == null
                                ? FontWeight.bold
                                : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Subsections (always shown if they exist)
        if (subsections != null)
          ...subsections.map((subsection) {
            final isSubsectionSelected = selectedSubsection == subsection;
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => controller.selectSubsection(subsection, section),
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 32, right: 8, top: 2, bottom: 2),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSubsectionSelected
                        ? AppColors.petrolBlue.withValues(alpha: 0.7)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isSubsectionSelected
                          ? AppColors.ocher
                          : AppColors.beige.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    subsection.title,
                    style: TextStyle(
                      color: AppColors.beige,
                      fontWeight: isSubsectionSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
      ],
    );
  }
}
