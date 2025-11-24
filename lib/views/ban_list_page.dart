import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/controllers/ban_list_controller.dart';

class BanListPage extends StatelessWidget {
  final BanListController controller;

  const BanListPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BanListFormat>(
      stream: controller.formatStream,
      initialData: controller.selectedFormat,
      builder: (context, formatSnapshot) {
        final selectedFormat =
            formatSnapshot.data ?? BanListFormat.primerBloqueRacialLibre;

        return Column(
          children: [
            // Main Tabs (Formats)
            Container(
              color: AppColors.coalGrey,
              padding: const EdgeInsets.all(8),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                children: BanListFormat.values.map((format) {
                  final isSelected = format == selectedFormat;
                  return Material(
                    color: isSelected ? AppColors.sageGreen : AppColors.beige,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () => controller.selectFormat(format),
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 230),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Text(
                          format.displayName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.coalGrey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Sub Tabs (Categories)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: StreamBuilder<BanListCategory>(
                stream: controller.categoryStream,
                initialData: controller.selectedCategory,
                builder: (context, categorySnapshot) {
                  final selectedCategory =
                      categorySnapshot.data ?? BanListCategory.banned;

                  return Container(
                    color: AppColors.coalGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: BanListCategory.values.map((category) {
                        final isSelected = category == selectedCategory;
                        return Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => controller.selectCategory(category),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: isSelected
                                          ? AppColors.brickRed
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  category.displayName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.beige
                                        : AppColors.white
                                            .withValues(alpha: 0.6),
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),

            // Content Area
            Expanded(
              child: StreamBuilder<BanListCategory>(
                stream: controller.categoryStream,
                initialData: controller.selectedCategory,
                builder: (context, categorySnapshot) {
                  final selectedCategory =
                      categorySnapshot.data ?? BanListCategory.banned;

                  return Container(
                    color: AppColors.coalGrey,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            selectedFormat.displayName,
                            style: const TextStyle(
                              color: AppColors.beige,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            selectedCategory.displayName,
                            style: const TextStyle(
                              color: AppColors.ocher,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
