import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/feature/game_formats/models/format_section.dart';
import 'package:myl_app_web/feature/game_formats/models/format_variant.dart';
import 'package:myl_app_web/feature/game_formats/controllers/game_formats_controller.dart';
import 'package:myl_app_web/feature/game_formats/widgets/index_item_widget.dart';
import 'package:myl_app_web/feature/game_formats/widgets/content/primer_bloque_content.dart';
import 'package:myl_app_web/feature/game_formats/widgets/content/bloque_furia_content.dart';
import 'package:myl_app_web/feature/game_formats/widgets/content/variant_content.dart';

class DesktopLayout extends StatelessWidget {
  final FormatSection selectedSection;
  final FormatVariant? selectedVariant;
  final GameFormatsController controller;

  const DesktopLayout({
    super.key,
    required this.selectedSection,
    required this.selectedVariant,
    required this.controller,
  });

  Widget _buildContent() {
    if (selectedVariant != null) {
      return VariantContent(variant: selectedVariant!);
    }

    switch (selectedSection) {
      case FormatSection.primerBloque:
        return const PrimerBloqueContent();
      case FormatSection.bloqueFuria:
        return const BloqueFuriaContent();
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
            children: FormatSection.values.map((section) {
              return IndexItemWidget(
                section: section,
                selectedSection: selectedSection,
                selectedVariant: selectedVariant,
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
