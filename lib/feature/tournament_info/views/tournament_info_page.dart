import 'package:flutter/material.dart';
import 'package:myl_app_web/feature/tournament_info/controllers/tournament_info_controller.dart';
import 'package:myl_app_web/feature/tournament_info/models/info_section.dart';
import 'package:myl_app_web/feature/tournament_info/models/tournament_subsection.dart';
import 'package:myl_app_web/feature/tournament_info/widgets/layouts/desktop_layout.dart';
import 'package:myl_app_web/feature/tournament_info/widgets/layouts/mobile_layout.dart';

class TournamentInfoPage extends StatelessWidget {
  final TournamentInfoController controller = TournamentInfoController();

  TournamentInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return StreamBuilder<InfoSection>(
      stream: controller.selectedSectionStream,
      initialData: controller.selectedSection,
      builder: (context, sectionSnapshot) {
        return StreamBuilder<TournamentSubsection?>(
          stream: controller.selectedSubsectionStream,
          initialData: controller.selectedSubsection,
          builder: (context, subsectionSnapshot) {
            final selectedSection = sectionSnapshot.data ?? InfoSection.general;
            final selectedSubsection = subsectionSnapshot.data;

            return isMobile
                ? MobileLayout(
                    selectedSection: selectedSection,
                    selectedSubsection: selectedSubsection,
                    controller: controller,
                  )
                : DesktopLayout(
                    selectedSection: selectedSection,
                    selectedSubsection: selectedSubsection,
                    controller: controller,
                  );
          },
        );
      },
    );
  }
}
