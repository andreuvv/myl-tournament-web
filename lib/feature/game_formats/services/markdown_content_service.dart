import 'package:flutter/services.dart';
import '../models/format_section.dart';
import '../models/format_variant.dart';

class MarkdownContentService {
  static Future<String> loadContent({
    required FormatSection section,
    FormatVariant? variant,
  }) async {
    String fileName;

    if (variant != null) {
      fileName = _getVariantFileName(variant);
    } else {
      fileName = _getSectionFileName(section);
    }

    final path = 'assets/markdown/game_formats/$fileName';

    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      print('Error loading markdown file: $path - $e');
      return '# Error\n\nNo se pudo cargar el contenido.';
    }
  }

  static String _getSectionFileName(FormatSection section) {
    switch (section) {
      case FormatSection.primerBloque:
        return 'primer_bloque.md';
      case FormatSection.bloqueFuria:
        return 'bloque_furia.md';
    }
  }

  static String _getVariantFileName(FormatVariant variant) {
    switch (variant) {
      case FormatVariant.primerBloqueRacialLibre:
        return 'pb_racial_libre.md';
      case FormatVariant.primerBloqueRacialEdicion:
        return 'pb_racial_edicion.md';
      case FormatVariant.bloqueFuriaRacialLibre:
        return 'bf_racial_libre.md';
      case FormatVariant.bloqueFuriaRacialLimitado:
        return 'bf_racial_edicion.md';
    }
  }
}
