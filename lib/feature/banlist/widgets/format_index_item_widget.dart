import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import '../controller/ban_list_controller.dart';

class FormatIndexItemWidget extends StatelessWidget {
  final BanListFormat format;
  final BanListFormat selectedFormat;
  final BanListCategory selectedCategory;
  final BanListController controller;

  const FormatIndexItemWidget({
    super.key,
    required this.format,
    required this.selectedFormat,
    required this.selectedCategory,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isFormatSelected = selectedFormat == format;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main format item (non-clickable)
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isFormatSelected ? AppColors.sageGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            format.displayName,
            style: TextStyle(
              color: isFormatSelected ? AppColors.coalGrey : AppColors.beige,
              fontWeight:
                  isFormatSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
        // Category subsections (always shown)
        ...BanListCategory.values.map((category) {
          final isCategorySelected =
              selectedCategory == category && selectedFormat == format;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => controller.selectFormatAndCategory(format, category),
              child: Container(
                margin: const EdgeInsets.only(
                    left: 32, right: 8, top: 2, bottom: 2),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: isCategorySelected
                      ? AppColors.sageGreen
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  category.displayName,
                  style: TextStyle(
                    color: isCategorySelected
                        ? AppColors.coalGrey
                        : AppColors.beige,
                    fontWeight: isCategorySelected
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
