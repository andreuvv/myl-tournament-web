import 'dart:async';
import 'package:myl_app_web/feature/game_formats/models/format_section.dart';
import 'package:myl_app_web/feature/game_formats/models/format_variant.dart';

class GameFormatsController {
  final _selectedSectionController =
      StreamController<FormatSection>.broadcast();
  final _selectedVariantController =
      StreamController<FormatVariant?>.broadcast();

  Stream<FormatSection> get selectedSectionStream =>
      _selectedSectionController.stream;
  Stream<FormatVariant?> get selectedVariantStream =>
      _selectedVariantController.stream;

  FormatSection _selectedSection = FormatSection.primerBloque;
  FormatVariant? _selectedVariant;

  FormatSection get selectedSection => _selectedSection;
  FormatVariant? get selectedVariant => _selectedVariant;

  void selectSection(FormatSection section) {
    _selectedSection = section;
    _selectedVariant = null;
    _selectedSectionController.add(_selectedSection);
    _selectedVariantController.add(_selectedVariant);
  }

  void selectVariant(FormatVariant variant, FormatSection section) {
    _selectedSection = section;
    _selectedVariant = variant;
    _selectedSectionController.add(_selectedSection);
    _selectedVariantController.add(_selectedVariant);
  }

  void dispose() {
    _selectedSectionController.close();
    _selectedVariantController.close();
  }
}
