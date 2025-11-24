import 'dart:async';

enum BanListFormat {
  primerBloqueRacialLibre,
  primerBloqueRacialEdicion,
  bloqueFuriaRacialLibre,
  bloqueFuriaRacialLimitado,
}

enum BanListCategory {
  banned,
  limitedX1,
  limitedX2,
}

extension BanListFormatExtension on BanListFormat {
  String get displayName {
    switch (this) {
      case BanListFormat.primerBloqueRacialLibre:
        return 'Primer Bloque Racial Libre';
      case BanListFormat.primerBloqueRacialEdicion:
        return 'Primer Bloque Racial Edición';
      case BanListFormat.bloqueFuriaRacialLibre:
        return 'Bloque Furia Racial Libre';
      case BanListFormat.bloqueFuriaRacialLimitado:
        return 'Bloque Furia Racial Limitado';
    }
  }
}

extension BanListCategoryExtension on BanListCategory {
  String get displayName {
    switch (this) {
      case BanListCategory.banned:
        return 'Baneadas';
      case BanListCategory.limitedX1:
        return 'Limitadas x1';
      case BanListCategory.limitedX2:
        return 'Limitadas x2';
    }
  }
}

class BanListController {
  final _formatController = StreamController<BanListFormat>.broadcast();
  final _categoryController = StreamController<BanListCategory>.broadcast();

  BanListFormat _selectedFormat = BanListFormat.primerBloqueRacialLibre;
  BanListCategory _selectedCategory = BanListCategory.banned;

  Stream<BanListFormat> get formatStream => _formatController.stream;
  Stream<BanListCategory> get categoryStream => _categoryController.stream;

  BanListFormat get selectedFormat => _selectedFormat;
  BanListCategory get selectedCategory => _selectedCategory;

  void selectFormat(BanListFormat format) {
    _selectedFormat = format;
    _formatController.add(_selectedFormat);
  }

  void selectCategory(BanListCategory category) {
    _selectedCategory = category;
    _categoryController.add(_selectedCategory);
  }

  void dispose() {
    _formatController.close();
    _categoryController.close();
  }
}
