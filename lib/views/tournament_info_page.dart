import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

enum InfoSection {
  general,
  tournamentSystem,
  prizesAndFunding,
  participants,
  schedule,
}

enum TournamentSubsection {
  md1,
  md3,
  mulligan,
  scoring,
  timing,
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

class TournamentInfoPage extends StatefulWidget {
  const TournamentInfoPage({super.key});

  @override
  State<TournamentInfoPage> createState() => _TournamentInfoPageState();
}

class _TournamentInfoPageState extends State<TournamentInfoPage> {
  InfoSection _selectedSection = InfoSection.general;
  TournamentSubsection? _selectedSubsection;

  Widget _buildContent() {
    if (_selectedSubsection != null) {
      return _buildSubsectionContent(_selectedSubsection!);
    }

    switch (_selectedSection) {
      case InfoSection.general:
        return _buildGeneralInfo();
      case InfoSection.tournamentSystem:
        return _buildTournamentSystem();
      case InfoSection.prizesAndFunding:
        return _buildPrizesAndFunding();
      case InfoSection.participants:
        return _buildParticipants();
      case InfoSection.schedule:
        return _buildSchedule();
    }
  }

  Widget _buildGeneralInfo() {
    return const Center(
      child: Text(
        'Información General del Torneo',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildTournamentSystem() {
    return const Center(
      child: Text(
        'Sistema de Torneo',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildPrizesAndFunding() {
    return const Center(
      child: Text(
        'Premios y Financiamiento',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildParticipants() {
    return const Center(
      child: Text(
        'Participantes',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildSchedule() {
    return const Center(
      child: Text(
        'Cronograma',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildSubsectionContent(TournamentSubsection subsection) {
    return Center(
      child: Text(
        subsection.title,
        style: const TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildIndexItem(InfoSection section) {
    final isSectionSelected = _selectedSection == section;
    final subsections = section.subsections;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Main section item
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _selectedSection = section;
                _selectedSubsection = null;
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: isSectionSelected && _selectedSubsection == null
                    ? AppColors.petrolBlue
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSectionSelected && _selectedSubsection == null
                      ? AppColors.ocher
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    section.icon,
                    color: AppColors.beige,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      section.title,
                      style: TextStyle(
                        color: AppColors.beige,
                        fontWeight:
                            isSectionSelected && _selectedSubsection == null
                                ? FontWeight.bold
                                : FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Subsections (always shown if they exist)
        if (subsections != null)
          ...subsections.map((subsection) {
            final isSubsectionSelected = _selectedSubsection == subsection;
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSubsection = subsection;
                    _selectedSection = section;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 32, right: 8, top: 2, bottom: 2),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSubsectionSelected
                        ? AppColors.petrolBlue.withValues(alpha: 0.7)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isSubsectionSelected
                          ? AppColors.ocher
                          : AppColors.beige.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    subsection.title,
                    style: TextStyle(
                      color: AppColors.beige,
                      fontWeight: isSubsectionSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left sidebar - 1/4 of screen
        Container(
          width: MediaQuery.of(context).size.width / 4,
          color: AppColors.coalGrey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: InfoSection.values.map((section) {
              return _buildIndexItem(section);
            }).toList(),
          ),
        ),
        // Right content - 3/4 of screen
        Expanded(
          child: Container(
            color: AppColors.coalGrey,
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    final currentTitle = _selectedSubsection?.title ?? _selectedSection.title;

    return Column(
      children: [
        // Fixed header with title and menu
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: AppColors.coalGrey,
          ),
          child: Row(
            children: [
              PopupMenuButton<dynamic>(
                icon: const Icon(Icons.menu, color: AppColors.beige),
                color: AppColors.coalGrey,
                onSelected: (value) {
                  setState(() {
                    if (value is InfoSection) {
                      _selectedSection = value;
                      _selectedSubsection = null;
                    } else if (value is TournamentSubsection) {
                      _selectedSubsection = value;
                      _selectedSection = InfoSection.tournamentSystem;
                    }
                  });
                },
                itemBuilder: (context) {
                  List<PopupMenuEntry<dynamic>> items = [];
                  for (var section in InfoSection.values) {
                    // Add section item
                    items.add(
                      PopupMenuItem(
                        value: section,
                        child: Row(
                          children: [
                            Icon(section.icon,
                                color: AppColors.beige, size: 18),
                            const SizedBox(width: 12),
                            Text(
                              section.title,
                              style: const TextStyle(
                                color: AppColors.beige,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    // Add subsection items if they exist
                    if (section.subsections != null) {
                      for (var subsection in section.subsections!) {
                        items.add(
                          PopupMenuItem(
                            value: subsection,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Text(
                                subsection.title,
                                style: TextStyle(
                                  color: AppColors.beige.withValues(alpha: 0.9),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }
                    // Add divider between sections (except after last)
                    if (section != InfoSection.values.last) {
                      items.add(const PopupMenuDivider());
                    }
                  }
                  return items;
                },
              ),
              Expanded(
                child: Text(
                  currentTitle,
                  style: const TextStyle(
                    color: AppColors.beige,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Content area
        Expanded(
          child: Container(
            color: AppColors.coalGrey,
            child: _buildContent(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return isMobile ? _buildMobileLayout() : _buildDesktopLayout();
  }
}
