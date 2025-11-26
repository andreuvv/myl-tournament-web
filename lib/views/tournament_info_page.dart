import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

enum InfoSection {
  general,
  rules,
  prizes,
  schedule,
  location,
}

extension InfoSectionExtension on InfoSection {
  String get title {
    switch (this) {
      case InfoSection.general:
        return 'Información General';
      case InfoSection.rules:
        return 'Reglas del Torneo';
      case InfoSection.prizes:
        return 'Premios';
      case InfoSection.schedule:
        return 'Cronograma';
      case InfoSection.location:
        return 'Ubicación';
    }
  }

  IconData get icon {
    switch (this) {
      case InfoSection.general:
        return Icons.info_outline;
      case InfoSection.rules:
        return Icons.gavel;
      case InfoSection.prizes:
        return Icons.emoji_events;
      case InfoSection.schedule:
        return Icons.calendar_today;
      case InfoSection.location:
        return Icons.place;
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

  Widget _buildContent(InfoSection section) {
    switch (section) {
      case InfoSection.general:
        return _buildGeneralInfo();
      case InfoSection.rules:
        return _buildRules();
      case InfoSection.prizes:
        return _buildPrizes();
      case InfoSection.schedule:
        return _buildSchedule();
      case InfoSection.location:
        return _buildLocation();
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

  Widget _buildRules() {
    return const Center(
      child: Text(
        'Reglas del Torneo',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildPrizes() {
    return const Center(
      child: Text(
        'Premios',
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

  Widget _buildLocation() {
    return const Center(
      child: Text(
        'Ubicación',
        style: TextStyle(color: AppColors.beige, fontSize: 24),
      ),
    );
  }

  Widget _buildIndexItem(InfoSection section) {
    final isSelected = _selectedSection == section;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedSection = section;
          });
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.petrolBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? AppColors.ocher : Colors.transparent,
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
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
            child: _buildContent(_selectedSection),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
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
              PopupMenuButton<InfoSection>(
                icon: const Icon(Icons.menu, color: AppColors.beige),
                color: AppColors.coalGrey,
                onSelected: (section) {
                  setState(() {
                    _selectedSection = section;
                  });
                },
                itemBuilder: (context) => InfoSection.values.map((section) {
                  return PopupMenuItem(
                    value: section,
                    child: Row(
                      children: [
                        Icon(section.icon, color: AppColors.beige, size: 18),
                        const SizedBox(width: 12),
                        Text(
                          section.title,
                          style: const TextStyle(color: AppColors.beige),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              Expanded(
                child: Text(
                  _selectedSection.title,
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
            child: _buildContent(_selectedSection),
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
