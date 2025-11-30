import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import '../../models/format_section.dart';
import '../../models/format_variant.dart';
import '../../controllers/game_formats_controller.dart';
import '../content/primer_bloque_content.dart';
import '../content/bloque_furia_content.dart';
import '../content/variant_content.dart';

class MobileLayout extends StatelessWidget {
  final FormatSection selectedSection;
  final FormatVariant? selectedVariant;
  final GameFormatsController controller;

  const MobileLayout({
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
    final currentTitle = selectedVariant?.title ?? selectedSection.title;

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
                  if (value is FormatSection) {
                    controller.selectSection(value);
                  } else if (value is FormatVariant) {
                    // Determine parent section based on variant
                    FormatSection parentSection;
                    if (value == FormatVariant.primerBloqueRacialLibre ||
                        value == FormatVariant.primerBloqueRacialEdicion) {
                      parentSection = FormatSection.primerBloque;
                    } else {
                      parentSection = FormatSection.bloqueFuria;
                    }
                    controller.selectVariant(value, parentSection);
                  }
                },
                itemBuilder: (context) {
                  List<PopupMenuEntry<dynamic>> items = [];
                  for (var section in FormatSection.values) {
                    final isSectionSelected =
                        selectedSection == section && selectedVariant == null;
                    // Add section item
                    items.add(
                      PopupMenuItem(
                        value: section,
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSectionSelected
                                ? AppColors.sageGreen.withValues(alpha: 0.3)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Icon(section.icon,
                                  color: isSectionSelected
                                      ? AppColors.sageGreen
                                      : AppColors.beige,
                                  size: 18),
                              const SizedBox(width: 12),
                              Text(
                                section.title,
                                style: TextStyle(
                                  color: isSectionSelected
                                      ? AppColors.sageGreen
                                      : AppColors.beige,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    // Add variant items if they exist
                    if (section.variants != null) {
                      for (var variant in section.variants!) {
                        final isVariantSelected = selectedVariant == variant;
                        items.add(
                          PopupMenuItem(
                            value: variant,
                            child: Container(
                              padding: const EdgeInsets.only(left: 24),
                              decoration: BoxDecoration(
                                color: isVariantSelected
                                    ? AppColors.sageGreen.withValues(alpha: 0.3)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  variant.title,
                                  style: TextStyle(
                                    color: isVariantSelected
                                        ? AppColors.sageGreen
                                        : AppColors.beige
                                            .withValues(alpha: 0.9),
                                    fontSize: 13,
                                    fontWeight: isVariantSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    // Add divider between sections (except after last)
                    if (section != FormatSection.values.last) {
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
