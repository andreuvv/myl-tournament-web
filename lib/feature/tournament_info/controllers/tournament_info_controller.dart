import 'dart:async';
import 'package:myl_app_web/feature/tournament_info/models/info_section.dart';
import 'package:myl_app_web/feature/tournament_info/models/tournament_subsection.dart';

class TournamentInfoController {
  final _selectedSectionController = StreamController<InfoSection>.broadcast();
  final _selectedSubsectionController =
      StreamController<TournamentSubsection?>.broadcast();

  Stream<InfoSection> get selectedSectionStream =>
      _selectedSectionController.stream;
  Stream<TournamentSubsection?> get selectedSubsectionStream =>
      _selectedSubsectionController.stream;

  InfoSection _selectedSection = InfoSection.general;
  TournamentSubsection? _selectedSubsection;

  InfoSection get selectedSection => _selectedSection;
  TournamentSubsection? get selectedSubsection => _selectedSubsection;

  void selectSection(InfoSection section) {
    _selectedSection = section;
    _selectedSubsection = null;
    _selectedSectionController.add(_selectedSection);
    _selectedSubsectionController.add(_selectedSubsection);
  }

  void selectSubsection(TournamentSubsection subsection, InfoSection section) {
    _selectedSection = section;
    _selectedSubsection = subsection;
    _selectedSectionController.add(_selectedSection);
    _selectedSubsectionController.add(_selectedSubsection);
  }

  void dispose() {
    _selectedSectionController.close();
    _selectedSubsectionController.close();
  }
}
