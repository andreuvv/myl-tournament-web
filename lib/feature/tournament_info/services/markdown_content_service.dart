import 'package:flutter/services.dart';
import '../models/info_section.dart';
import '../models/tournament_subsection.dart';

class MarkdownContentService {
  static Future<String> loadContent({
    required InfoSection section,
    TournamentSubsection? subsection,
  }) async {
    String fileName;

    if (subsection != null) {
      fileName = _getSubsectionFileName(subsection);
    } else {
      fileName = _getSectionFileName(section);
    }

    final path = 'assets/markdown/tournament_info/$fileName';

    try {
      return await rootBundle.loadString(path);
    } catch (e) {
      print('Error loading markdown file: $path - $e');
      return '# Error\n\nNo se pudo cargar el contenido.';
    }
  }

  static String _getSectionFileName(InfoSection section) {
    switch (section) {
      case InfoSection.general:
        return 'general.md';
      case InfoSection.tournamentSystem:
        return 'tournament_system.md';
      case InfoSection.prizesAndFunding:
        return 'prizes_and_funding.md';
      case InfoSection.participants:
        return 'participants.md';
      case InfoSection.schedule:
        return 'schedule.md';
    }
  }

  static String _getSubsectionFileName(TournamentSubsection subsection) {
    switch (subsection) {
      case TournamentSubsection.md1:
        return 'md1.md';
      case TournamentSubsection.md3:
        return 'md3.md';
      case TournamentSubsection.mulligan:
        return 'mulligan.md';
      case TournamentSubsection.scoring:
        return 'scoring.md';
      case TournamentSubsection.timing:
        return 'timing.md';
    }
  }
}
