import 'package:flutter/material.dart';
import 'tournament_subsection.dart';

enum InfoSection {
  general,
  tournamentSystem,
  prizesAndFunding,
  participants,
  schedule,
}

extension InfoSectionExtension on InfoSection {
  String get title {
    switch (this) {
      case InfoSection.general:
        return 'Información General';
      case InfoSection.tournamentSystem:
        return 'Sistema de Torneo';
      case InfoSection.prizesAndFunding:
        return 'Premios y Financiamiento';
      case InfoSection.participants:
        return 'Participantes';
      case InfoSection.schedule:
        return 'Cronograma';
    }
  }

  IconData get icon {
    switch (this) {
      case InfoSection.general:
        return Icons.info_outline;
      case InfoSection.tournamentSystem:
        return Icons.gavel;
      case InfoSection.prizesAndFunding:
        return Icons.emoji_events;
      case InfoSection.participants:
        return Icons.people;
      case InfoSection.schedule:
        return Icons.calendar_today;
    }
  }

  List<TournamentSubsection>? get subsections {
    switch (this) {
      case InfoSection.tournamentSystem:
        return TournamentSubsection.values;
      default:
        return null;
    }
  }
}
