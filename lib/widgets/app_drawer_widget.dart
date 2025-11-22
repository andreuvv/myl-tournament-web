import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/static/mock_data.dart';

class AppDrawer extends StatelessWidget {
  final MenuOption selectedOption;
  final Function(MenuOption) onSelect;

  const AppDrawer({
    super.key,
    required this.selectedOption,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.parchment,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.forestDark,
              border: Border(
                bottom: BorderSide(color: AppColors.gold, width: 4),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.emoji_events, size: 48, color: AppColors.gold),
                  SizedBox(height: 10),
                  Text(
                    "PREMIER MITOLÓGICO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _MenuTile(
                  icon: Icons.home,
                  title: "Inicio",
                  isSelected: selectedOption == MenuOption.home,
                  onTap: () => onSelect(MenuOption.home),
                ),
                _MenuTile(
                  icon: Icons.block,
                  title: "Ban List Actualizada",
                  isSelected: selectedOption == MenuOption.banList,
                  onTap: () => onSelect(MenuOption.banList),
                ),
                _MenuTile(
                  icon: Icons.layers,
                  title: "Formatos",
                  isSelected: selectedOption == MenuOption.formats,
                  onTap: () => onSelect(MenuOption.formats),
                ),
                _MenuTile(
                  icon: Icons.info,
                  title: "Info Torneo",
                  isSelected: selectedOption == MenuOption.info,
                  onTap: () => onSelect(MenuOption.info),
                ),
                const Divider(color: AppColors.gold),
                _MenuTile(
                  icon: Icons.build_circle,
                  title: "Deck Builder",
                  isSelected: selectedOption == MenuOption.deckBuilder,
                  onTap: () => onSelect(MenuOption.deckBuilder),
                  isHighlight: true,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "© 2025 Premier Mitológico",
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isHighlight;

  const _MenuTile({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.isHighlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isHighlight
        ? AppColors.crimson
        : (isSelected ? AppColors.forestDark : Colors.grey[700]);

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected || isHighlight ? AppColors.gold : color,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: isSelected || isHighlight
              ? FontWeight.bold
              : FontWeight.normal,
          fontSize: 16,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.gold.withValues(alpha: 0.2),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      shape: isSelected
          ? const Border(left: BorderSide(color: AppColors.gold, width: 4))
          : null,
    );
  }
}
