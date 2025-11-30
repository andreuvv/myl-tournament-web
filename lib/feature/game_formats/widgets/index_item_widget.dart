import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/feature/game_formats/controllers/game_formats_controller.dart';
import 'package:myl_app_web/feature/game_formats/models/format_section.dart';
import 'package:myl_app_web/feature/game_formats/models/format_variant.dart';

class IndexItemWidget extends StatelessWidget {
  final FormatSection section;
  final FormatSection selectedSection;
  final FormatVariant? selectedVariant;
  final GameFormatsController controller;

  const IndexItemWidget({
    super.key,
    required this.section,
    required this.selectedSection,
    required this.selectedVariant,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isSectionSelected = selectedSection == section;
    final variants = section.variants;

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
                color: isSectionSelected && selectedVariant == null
                    ? AppColors.sageGreen
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    section.icon,
                    color: isSectionSelected && selectedVariant == null
                        ? AppColors.coalGrey
                        : AppColors.beige,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      section.title,
                      style: TextStyle(
                        color: isSectionSelected && selectedVariant == null
                            ? AppColors.coalGrey
                            : AppColors.beige,
                        fontWeight: isSectionSelected && selectedVariant == null
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
        // Variants (always shown if they exist)
        if (variants != null)
          ...variants.map((variant) {
            final isVariantSelected = selectedVariant == variant;
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => controller.selectVariant(variant, section),
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 32, right: 8, top: 2, bottom: 2),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isVariantSelected
                        ? AppColors.sageGreen
                        : AppColors.coalGrey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    variant.title,
                    style: TextStyle(
                      color: isVariantSelected
                          ? AppColors.coalGrey
                          : AppColors.beige,
                      fontWeight: isVariantSelected
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
