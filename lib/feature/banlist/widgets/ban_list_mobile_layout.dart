import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import '../controller/ban_list_controller.dart';
import '../model/ban_list_data_model.dart';
import 'ban_list_content.dart';
import 'info_icon_widget.dart';

class BanListMobileLayout extends StatelessWidget {
  final BanListFormat selectedFormat;
  final BanListCategory selectedCategory;
  final BanListData? banListData;
  final BanListController controller;

  const BanListMobileLayout({
    super.key,
    required this.selectedFormat,
    required this.selectedCategory,
    required this.banListData,
    required this.controller,
  });

  String get currentTitle {
    return '${selectedFormat.displayName} - ${selectedCategory.displayName}';
  }

  @override
  Widget build(BuildContext context) {
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
              PopupMenuButton<Map<String, dynamic>>(
                icon: const Icon(Icons.menu, color: AppColors.beige),
                color: AppColors.coalGrey,
                onSelected: (value) {
                  controller.selectFormatAndCategory(
                    value['format'] as BanListFormat,
                    value['category'] as BanListCategory,
                  );
                },
                itemBuilder: (context) {
                  List<PopupMenuEntry<Map<String, dynamic>>> items = [];
                  for (var format in BanListFormat.values) {
                    // Add format item (non-clickable header)
                    items.add(
                      PopupMenuItem(
                        enabled: false,
                        child: Text(
                          format.displayName,
                          style: const TextStyle(
                            color: AppColors.beige,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                    // Add category items
                    for (var category in BanListCategory.values) {
                      items.add(
                        PopupMenuItem(
                          value: {'format': format, 'category': category},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              category.displayName,
                              style: TextStyle(
                                color: AppColors.beige.withValues(alpha: 0.9),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    // Add divider between formats (except after last)
                    if (format != BanListFormat.values.last) {
                      items.add(const PopupMenuDivider());
                    }
                  }
                  return items;
                },
              ),
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        currentTitle,
                        style: const TextStyle(
                          color: AppColors.beige,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const InfoIconWidget(),
                    const SizedBox(width: 8),
                    Text(
                      controller.lastUpdateDate,
                      style: TextStyle(
                        color: AppColors.beige.withOpacity(0.7),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Content area
        Expanded(
          child: Container(
            color: AppColors.coalGrey,
            child: BanListContent(
              selectedCategory: selectedCategory,
              banListData: banListData,
            ),
          ),
        ),
      ],
    );
  }
}
