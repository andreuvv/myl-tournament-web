import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/feature/banlist/controller/ban_list_controller.dart';

class BanListPage extends StatelessWidget {
  final BanListController controller;

  const BanListPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;
    final isTablet = screenWidth >= 800 && screenWidth < 1200;

    // Dynamic sizing based on screen width
    final formatTabHeight = isMobile ? 100.0 : (isTablet ? 110.0 : 70.0);
    final formatTabMinWidth = isMobile ? 180.0 : 250.0;
    final formatTabHorizontalPadding = isMobile ? 12.0 : 20.0;
    final formatTabVerticalPadding = isMobile ? 10.0 : 14.0;
    final formatTabFontSize = isMobile ? 13.0 : 15.0;

    return StreamBuilder<BanListFormat>(
      stream: controller.formatStream,
      initialData: controller.selectedFormat,
      builder: (context, formatSnapshot) {
        final selectedFormat =
            formatSnapshot.data ?? BanListFormat.primerBloqueRacialLibre;

        return StreamBuilder<BanListCategory>(
          stream: controller.categoryStream,
          initialData: controller.selectedCategory,
          builder: (context, categorySnapshot) {
            final selectedCategory =
                categorySnapshot.data ?? BanListCategory.banned;

            return CustomScrollView(
              slivers: [
                // Info text section that scrolls away
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Para todos los formatos, las cartas sin raza, cartas con "SP" en su nombre o cartas con ★ no se pueden incluir en el mazo.',
                            style: const TextStyle(
                              color: AppColors.beige,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Las imagenes usadas son referenciales y pueden o no corresponder a la última versión impresa de la carta. \nLas siguientes restricciones aplican a cualquier versión de la carta.',
                            style: const TextStyle(
                              color: AppColors.beige,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),

                // Pinned Format Tabs
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyHeaderDelegate(
                    minHeight: formatTabHeight,
                    maxHeight: formatTabHeight,
                    child: Container(
                      color: AppColors.coalGrey,
                      padding: const EdgeInsets.all(8),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: BanListFormat.values.map((format) {
                          final isSelected = format == selectedFormat;
                          return Material(
                            color: isSelected
                                ? AppColors.sageGreen
                                : AppColors.beige,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
                              onTap: () => controller.selectFormat(format),
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                constraints:
                                    BoxConstraints(minWidth: formatTabMinWidth),
                                padding: EdgeInsets.symmetric(
                                    horizontal: formatTabHorizontalPadding,
                                    vertical: formatTabVerticalPadding),
                                child: Text(
                                  format.displayName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.coalGrey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: formatTabFontSize,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                // Pinned Category Tabs
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyHeaderDelegate(
                    minHeight: 50,
                    maxHeight: 50,
                    child: Container(
                      color: AppColors.coalGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: BanListCategory.values.map((category) {
                          final isSelected = category == selectedCategory;
                          return Expanded(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () =>
                                    controller.selectCategory(category),
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
                    ),
                  ),
                ),

                // Content Area
                StreamBuilder(
                  stream: controller.dataStream,
                  initialData: controller.currentData,
                  builder: (context, dataSnapshot) {
                    final banListData = dataSnapshot.data;

                    if (banListData == null) {
                      return SliverFillRemaining(
                        child: Container(
                          color: AppColors.coalGrey,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.ocher,
                            ),
                          ),
                        ),
                      );
                    }

                    // Get cards for selected category
                    final cards = selectedCategory == BanListCategory.banned
                        ? banListData.banned
                        : selectedCategory == BanListCategory.limitedX1
                            ? banListData.limitedX1
                            : banListData.limitedX2;

                    if (cards.isEmpty) {
                      return SliverFillRemaining(
                        child: Container(
                          color: AppColors.coalGrey,
                          child: Center(
                            child: Text(
                              'No hay cartas en esta categoría',
                              style: const TextStyle(
                                color: AppColors.beige,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 0.7,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final card = cards[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: AppColors.beige,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.brickRed,
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      card.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppColors.coalGrey,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: card.imageUrl.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(8)),
                                              child: Image.network(
                                                card.imageUrl,
                                                fit: BoxFit.contain,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    color: AppColors.coalGrey
                                                        .withValues(alpha: 0.1),
                                                    child: const Center(
                                                      child: Icon(
                                                        Icons.broken_image,
                                                        color:
                                                            AppColors.coalGrey,
                                                        size: 48,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                        : Container(
                                            color: AppColors.coalGrey
                                                .withValues(alpha: 0.1),
                                            child: const Center(
                                              child: Icon(
                                                Icons.image_not_supported,
                                                color: AppColors.coalGrey,
                                                size: 48,
                                              ),
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: cards.length,
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
