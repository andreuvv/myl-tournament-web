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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Para todos los formatos, las cartas sin raza, cartas con "SP" en su nombre o cartas con ★ no se pueden incluir en el mazo.',
                  style: const TextStyle(
                    color: AppColors.beige,
                    fontSize: 16,
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
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
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

                  return StreamBuilder(
                    stream: controller.dataStream,
                    initialData: controller.currentData,
                    builder: (context, dataSnapshot) {
                      final banListData = dataSnapshot.data;

                      if (banListData == null) {
                        return Container(
                          color: AppColors.coalGrey,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.ocher,
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
                        return Container(
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
                        );
                      }

                      return Container(
                        color: AppColors.coalGrey,
                        padding: const EdgeInsets.all(20),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
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
                        ),
                      );
                    },
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
