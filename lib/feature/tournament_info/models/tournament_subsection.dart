enum TournamentSubsection {
  md1,
  md3,
  mulligan,
  scoring,
  timing,
}

extension TournamentSubsectionExtension on TournamentSubsection {
  String get title {
    switch (this) {
      case TournamentSubsection.md1:
        return 'Torneo Md1';
      case TournamentSubsection.md3:
        return 'Torneo Md3';
      case TournamentSubsection.mulligan:
        return 'Mulligan';
      case TournamentSubsection.scoring:
        return 'Puntuación';
      case TournamentSubsection.timing:
        return 'Tiempos';
    }
  }
}
