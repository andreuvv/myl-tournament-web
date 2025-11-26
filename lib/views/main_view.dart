import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/static/mock_data.dart';

class MainView extends StatelessWidget {
  final MenuOption selectedOption;
  final Function(MenuOption) onMenuSelect;
  final Widget content;

  const MainView({
    super.key,
    required this.selectedOption,
    required this.onMenuSelect,
    required this.content,
  });

  Widget _buildNavButton(String title, MenuOption option,
      {bool disabled = false, IconData? icon}) {
    final isSelected = selectedOption == option;

    return MouseRegion(
      cursor: disabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: disabled ? null : () => onMenuSelect(option),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.petrolBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18,
                  color: disabled
                      ? Colors.grey
                      : (isSelected ? AppColors.beige : AppColors.beige),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                title,
                style: TextStyle(
                  color: disabled
                      ? Colors.grey
                      : (isSelected ? AppColors.beige : AppColors.beige),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                  decoration: disabled
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: AppColors.beige,
                  decorationThickness: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            // Left: Logo/Title with home navigation
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onMenuSelect(MenuOption.home),
                child: Image.asset(
                  'assets/images/logo_premier.png',
                  height: 55,
                  //fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
            // Center: Main navigation
            _buildNavButton("Info Torneo", MenuOption.info, icon: Icons.info),
            const SizedBox(width: 8),
            _buildNavButton("Ban List Actualizada", MenuOption.banList,
                icon: Icons.block),
            const SizedBox(width: 8),
            _buildNavButton("Formatos", MenuOption.formats, icon: Icons.layers),
            const Spacer(),
            // Right: Deck Builder (disabled)
            _buildNavButton("Deck Builder", MenuOption.deckBuilder,
                disabled: true, icon: Icons.build_circle),
          ],
        ),
        toolbarHeight: 70,
      ),
      body: SelectionArea(child: content),
    );
  }
}
