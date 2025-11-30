import 'package:flutter/material.dart';
import 'package:myl_app_web/feature/game_formats/controllers/game_formats_controller.dart';
import 'package:myl_app_web/feature/game_formats/models/format_section.dart';
import 'package:myl_app_web/feature/game_formats/models/format_variant.dart';
import 'package:myl_app_web/feature/game_formats/widgets/layouts/desktop_layout.dart';
import 'package:myl_app_web/feature/game_formats/widgets/layouts/mobile_layout.dart';

class GameFormatsPage extends StatelessWidget {
  final GameFormatsController controller = GameFormatsController();

  GameFormatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return StreamBuilder<FormatSection>(
      stream: controller.selectedSectionStream,
      initialData: controller.selectedSection,
      builder: (context, sectionSnapshot) {
        return StreamBuilder<FormatVariant?>(
          stream: controller.selectedVariantStream,
          initialData: controller.selectedVariant,
          builder: (context, variantSnapshot) {
            final selectedSection = sectionSnapshot.data ?? FormatSection.primerBloque;
            final selectedVariant = variantSnapshot.data;

            return isMobile
                ? MobileLayout(
                    selectedSection: selectedSection,
                    selectedVariant: selectedVariant,
                    controller: controller,
                  )
                : DesktopLayout(
                    selectedSection: selectedSection,
                    selectedVariant: selectedVariant,
                    controller: controller,
                  );
          },
        );
      },
    );
  }
}
