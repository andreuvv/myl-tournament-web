import 'package:flutter/material.dart';
import 'package:myl_app_web/feature/banlist/controller/ban_list_controller.dart';
import '../widgets/ban_list_desktop_layout.dart';
import '../widgets/ban_list_mobile_layout.dart';

class BanListPage extends StatelessWidget {
  final BanListController controller;

  const BanListPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return StreamBuilder<BanListFormat>(
      stream: controller.formatStream,
      initialData: controller.selectedFormat,
      builder: (context, formatSnapshot) {
        return StreamBuilder<BanListCategory>(
          stream: controller.categoryStream,
          initialData: controller.selectedCategory,
          builder: (context, categorySnapshot) {
            return StreamBuilder(
              stream: controller.dataStream,
              initialData: controller.currentData,
              builder: (context, dataSnapshot) {
                final selectedFormat = formatSnapshot.data ??
                    BanListFormat.primerBloqueRacialLibre;
                final selectedCategory =
                    categorySnapshot.data ?? BanListCategory.banned;
                final banListData = dataSnapshot.data;

                return isMobile
                    ? BanListMobileLayout(
                        selectedFormat: selectedFormat,
                        selectedCategory: selectedCategory,
                        banListData: banListData,
                        controller: controller,
                      )
                    : BanListDesktopLayout(
                        selectedFormat: selectedFormat,
                        selectedCategory: selectedCategory,
                        banListData: banListData,
                        controller: controller,
                      );
              },
            );
          },
        );
      },
    );
  }
}
