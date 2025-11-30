enum FormatVariant {
  primerBloqueRacialLibre,
  primerBloqueRacialEdicion,
  bloqueFuriaRacialLibre,
  bloqueFuriaRacialLimitado,
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
}
