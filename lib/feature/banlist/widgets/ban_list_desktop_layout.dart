import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import '../controller/ban_list_controller.dart';
import '../model/ban_list_data_model.dart';
import 'format_index_item_widget.dart';
import 'ban_list_content.dart';
import 'info_icon_widget.dart';

class BanListDesktopLayout extends StatelessWidget {
  final BanListFormat selectedFormat;
  final BanListCategory selectedCategory;
  final BanListData? banListData;
  final BanListController controller;

  const BanListDesktopLayout({
    super.key,
    required this.selectedFormat,
    required this.selectedCategory,
    required this.banListData,
    required this.controller,
  });

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
            children: BanListFormat.values.map((format) {
              return FormatIndexItemWidget(
                format: format,
                selectedFormat: selectedFormat,
                selectedCategory: selectedCategory,
                controller: controller,
              );
            }).toList(),
          ),
        ),
        // Right content - 3/4 of screen
        Expanded(
          child: Container(
            color: AppColors.coalGrey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with info icon
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          '${selectedFormat.displayName} - ${selectedCategory.displayName}',
                          style: const TextStyle(
                            color: AppColors.beige,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const InfoIconWidget(),
                      const SizedBox(width: 12),
                      Text(
                        controller.lastUpdateDate,
                        style: TextStyle(
                          color: AppColors.beige.withOpacity(0.7),
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: BanListContent(
                    selectedCategory: selectedCategory,
                    banListData: banListData,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
