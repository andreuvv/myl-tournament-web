import 'package:flutter/material.dart';
import 'format_variant.dart';

enum FormatSection {
  primerBloque,
  bloqueFuria,
}

extension FormatSectionExtension on FormatSection {
  String get title {
    switch (this) {
      case FormatSection.primerBloque:
        return 'Primer Bloque';
      case FormatSection.bloqueFuria:
        return 'Bloque Furia';
    }
  }

  IconData get icon {
    switch (this) {
      case FormatSection.primerBloque:
        return Icons.filter_1;
      case FormatSection.bloqueFuria:
        return Icons.whatshot;
    }
  }

  List<FormatVariant>? get variants {
    switch (this) {
      case FormatSection.primerBloque:
        return [
          FormatVariant.primerBloqueRacialLibre,
          FormatVariant.primerBloqueRacialEdicion,
        ];
      case FormatSection.bloqueFuria:
        return [
          FormatVariant.bloqueFuriaRacialLibre,
          FormatVariant.bloqueFuriaRacialLimitado,
        ];
    }
  }
}
