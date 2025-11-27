import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import '../controller/ban_list_controller.dart';
import '../model/ban_list_data_model.dart';

class BanListContent extends StatelessWidget {
  final BanListCategory selectedCategory;
  final BanListData? banListData;

  const BanListContent({
    super.key,
    required this.selectedCategory,
    required this.banListData,
  });

  @override
  Widget build(BuildContext context) {
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
        ? banListData!.banned
        : selectedCategory == BanListCategory.limitedX1
            ? banListData!.limitedX1
            : banListData!.limitedX2;

    return CustomScrollView(
      slivers: [
        // Content Area
        if (cards.isEmpty)
          SliverFillRemaining(
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
          )
        else
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                    borderRadius: const BorderRadius.vertical(
                                        bottom: Radius.circular(8)),
                                    child: Image.network(
                                      card.imageUrl,
                                      fit: BoxFit.contain,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: AppColors.coalGrey
                                              .withValues(alpha: 0.1),
                                          child: const Center(
                                            child: Icon(
                                              Icons.broken_image,
                                              color: AppColors.coalGrey,
                                              size: 48,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Container(
                                  color:
                                      AppColors.coalGrey.withValues(alpha: 0.1),
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
          ),
      ],
    );
  }
}
