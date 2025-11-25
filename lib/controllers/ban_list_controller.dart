import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:myl_app_web/models/ban_list_data_model.dart';

enum BanListFormat {
  primerBloqueRacialLibre,
  primerBloqueRacialEdicion,
  bloqueFuriaRacialLibre,
  bloqueFuriaRacialLimitado,
}

enum BanListCategory { banned, limitedX1, limitedX2 }

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

  String get jsonFile {
    switch (this) {
      case BanListFormat.primerBloqueRacialLibre:
        return 'json/banlist_pb_libre.json';
      case BanListFormat.primerBloqueRacialEdicion:
        return 'json/banlist_pb_edition.json';
      case BanListFormat.bloqueFuriaRacialLibre:
        return 'json/banlist_bf_libre.json';
      case BanListFormat.bloqueFuriaRacialLimitado:
        return 'json/banlist_bf_limited.json';
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
  final _dataController = StreamController<BanListData?>.broadcast();

  BanListFormat _selectedFormat = BanListFormat.primerBloqueRacialLibre;
  BanListCategory _selectedCategory = BanListCategory.banned;
  BanListData? _currentData;

  Stream<BanListFormat> get formatStream => _formatController.stream;
  Stream<BanListCategory> get categoryStream => _categoryController.stream;
  Stream<BanListData?> get dataStream => _dataController.stream;

  BanListFormat get selectedFormat => _selectedFormat;
  BanListCategory get selectedCategory => _selectedCategory;
  BanListData? get currentData => _currentData;

  BanListController() {
    _loadData(_selectedFormat);
  }

  Future<void> _loadData(BanListFormat format) async {
    try {
      final path = 'assets/${format.jsonFile}';
      print('Attempting to load: $path');
      final jsonString = await rootBundle.loadString(path);
      print('Successfully loaded JSON, length: ${jsonString.length}');
      final jsonData = json.decode(jsonString);
      _currentData = BanListData.fromJson(jsonData);
      _dataController.add(_currentData);
      print(
        'Data loaded successfully: ${_currentData?.banned.length} banned cards',
      );
    } catch (e, stackTrace) {
      print('Error loading ban list data: $e');
      print('Stack trace: $stackTrace');
      _currentData = null;
      _dataController.add(null);
    }
  }

  void selectFormat(BanListFormat format) {
    _selectedFormat = format;
    _formatController.add(_selectedFormat);
    _loadData(format);
  }

  void selectCategory(BanListCategory category) {
    _selectedCategory = category;
    _categoryController.add(_selectedCategory);
  }

  void dispose() {
    _formatController.close();
    _categoryController.close();
    _dataController.close();
  }
}
