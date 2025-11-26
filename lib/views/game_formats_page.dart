import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

enum FormatBlock {
  primerBloque,
  bloqueFuria,
}

enum FormatVariant {
  primerBloqueRacialLibre,
  primerBloqueRacialEdicion,
  bloqueFuriaRacialLibre,
  bloqueFuriaRacialLimitado,
}

extension FormatBlockExtension on FormatBlock {
  String get title {
    switch (this) {
      case FormatBlock.primerBloque:
        return 'Primer Bloque';
      case FormatBlock.bloqueFuria:
        return 'Bloque Furia';
    }
  }

  IconData get icon {
    switch (this) {
      case FormatBlock.primerBloque:
        return Icons.filter_1;
      case FormatBlock.bloqueFuria:
        return Icons.whatshot;
    }
  }

  List<FormatVariant> get variants {
    switch (this) {
      case FormatBlock.primerBloque:
        return [
          FormatVariant.primerBloqueRacialLibre,
          FormatVariant.primerBloqueRacialEdicion,
        ];
      case FormatBlock.bloqueFuria:
        return [
          FormatVariant.bloqueFuriaRacialLibre,
          FormatVariant.bloqueFuriaRacialLimitado,
        ];
    }
  }
}

extension FormatVariantExtension on FormatVariant {
  String get title {
    switch (this) {
      case FormatVariant.primerBloqueRacialLibre:
        return 'Primer Bloque Racial Libre';
      case FormatVariant.primerBloqueRacialEdicion:
        return 'Primer Bloque Racial Edición';
      case FormatVariant.bloqueFuriaRacialLibre:
        return 'Bloque Furia Racial Libre';
      case FormatVariant.bloqueFuriaRacialLimitado:
        return 'Bloque Furia Racial Limitado';
    }
  }

  FormatBlock get parentBlock {
    switch (this) {
      case FormatVariant.primerBloqueRacialLibre:
      case FormatVariant.primerBloqueRacialEdicion:
        return FormatBlock.primerBloque;
      case FormatVariant.bloqueFuriaRacialLibre:
      case FormatVariant.bloqueFuriaRacialLimitado:
        return FormatBlock.bloqueFuria;
    }
  }
}

class GameFormatsPage extends StatefulWidget {
  const GameFormatsPage({super.key});

  @override
  State<GameFormatsPage> createState() => _GameFormatsPageState();
}

class _GameFormatsPageState extends State<GameFormatsPage> {
  FormatVariant? _selectedVariant;
  FormatBlock? _selectedBlock;

  Widget _buildContent() {
    if (_selectedVariant != null) {
      return _buildVariantContent(_selectedVariant!);
    } else if (_selectedBlock != null) {
      return _buildBlockContent(_selectedBlock!);
    }
    return const Center(
      child: Text(
        'Selecciona un formato',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildBlockContent(FormatBlock block) {
    return Center(
      child: Text(
        'Información General: ${block.title}',
        style: const TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildVariantContent(FormatVariant variant) {
    return Center(
      child: Text(
        variant.title,
        style: const TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildBlockItem(FormatBlock block) {
    final isBlockSelected = _selectedBlock == block;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main block item
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedBlock = block;
                _selectedVariant = null;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isBlockSelected && _selectedVariant == null
                    ? AppColors.petrolBlue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isBlockSelected && _selectedVariant == null
                      ? AppColors.ocher
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    block.icon,
                    color: AppColors.beige,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      block.title,
                      style: TextStyle(
                        color: AppColors.beige,
                        fontWeight: isBlockSelected && _selectedVariant == null
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
        // Variants (always shown)
        ...block.variants.map((variant) {
          final isVariantSelected = _selectedVariant == variant;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedVariant = variant;
                  _selectedBlock = null;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(
                    left: 32, right: 8, top: 2, bottom: 2),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: isVariantSelected
                      ? AppColors.petrolBlue.withValues(alpha: 0.7)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isVariantSelected
                        ? AppColors.ocher
                        : AppColors.beige.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  variant.title,
                  style: TextStyle(
                    color: AppColors.beige,
                    fontWeight:
                        isVariantSelected ? FontWeight.bold : FontWeight.normal,
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

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left sidebar - 1/4 of screen
        Container(
          width: MediaQuery.of(context).size.width / 4,
          decoration: const BoxDecoration(
            color: AppColors.coalGrey,
            border: Border(
              right: BorderSide(color: AppColors.ocher, width: 2),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: FormatBlock.values.map((block) {
              return _buildBlockItem(block);
            }).toList(),
          ),
        ),
        // Right content - 3/4 of screen
        Expanded(
          child: Container(
            color: AppColors.coalGrey,
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    final currentTitle =
        _selectedVariant?.title ?? _selectedBlock?.title ?? 'Formatos de Juego';

    return Column(
      children: [
        // Fixed header with title and menu
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: AppColors.coalGrey,
            border: Border(
              bottom: BorderSide(color: AppColors.ocher, width: 2),
            ),
          ),
          child: Row(
            children: [
              PopupMenuButton<dynamic>(
                icon: const Icon(Icons.menu, color: AppColors.beige),
                color: AppColors.coalGrey,
                onSelected: (value) {
                  setState(() {
                    if (value is FormatBlock) {
                      _selectedBlock = value;
                      _selectedVariant = null;
                    } else if (value is FormatVariant) {
                      _selectedVariant = value;
                      _selectedBlock = null;
                    }
                  });
                },
                itemBuilder: (context) {
                  List<PopupMenuEntry<dynamic>> items = [];
                  for (var block in FormatBlock.values) {
                    // Add block item
                    items.add(
                      PopupMenuItem(
                        value: block,
                        child: Row(
                          children: [
                            Icon(block.icon, color: AppColors.beige, size: 18),
                            const SizedBox(width: 12),
                            Text(
                              block.title,
                              style: const TextStyle(
                                color: AppColors.beige,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    // Add variant items
                    for (var variant in block.variants) {
                      items.add(
                        PopupMenuItem(
                          value: variant,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 24),
                            child: Text(
                              variant.title,
                              style: TextStyle(
                                color: AppColors.beige.withValues(alpha: 0.9),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    // Add divider between blocks
                    if (block != FormatBlock.values.last) {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return isMobile ? _buildMobileLayout() : _buildDesktopLayout();
  }
}
