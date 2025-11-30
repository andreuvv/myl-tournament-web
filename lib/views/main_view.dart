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
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: isMobile
            ? Row(
                children: [
                  // Logo on mobile
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => onMenuSelect(MenuOption.home),
                      child: Image.asset(
                        'assets/images/logo_premier.png',
                        height: 45,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Hamburger menu for mobile
                  PopupMenuButton<MenuOption>(
                    icon: const Icon(Icons.menu, color: AppColors.beige),
                    color: AppColors.coalGrey,
                    onSelected: (option) => onMenuSelect(option),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: MenuOption.info,
                        child: Row(
                          children: const [
                            Icon(Icons.info, color: AppColors.beige, size: 18),
                            SizedBox(width: 8),
                            Text('Info Torneo',
                                style: TextStyle(color: AppColors.beige)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: MenuOption.banList,
                        child: Row(
                          children: const [
                            Icon(Icons.block, color: AppColors.beige, size: 18),
                            SizedBox(width: 8),
                            Text('Ban List Nov 2025',
                                style: TextStyle(color: AppColors.beige)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: MenuOption.formats,
                        child: Row(
                          children: const [
                            Icon(Icons.layers,
                                color: AppColors.beige, size: 18),
                            SizedBox(width: 8),
                            Text('Formatos',
                                style: TextStyle(color: AppColors.beige)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        enabled: false,
                        child: Row(
                          children: const [
                            Icon(Icons.build_circle,
                                color: Colors.grey, size: 18),
                            SizedBox(width: 8),
                            Text('Deck Builder',
                                style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Row(
                children: [
                  // Left: Logo/Title with home navigation
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => onMenuSelect(MenuOption.home),
                      child: Image.asset(
                        'assets/images/logo_premier.png',
                        height: 55,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Center: Main navigation
                  _buildNavButton("Info Torneo", MenuOption.info,
                      icon: Icons.info),
                  const SizedBox(width: 8),
                  _buildNavButton("Ban List Nov 2025", MenuOption.banList,
                      icon: Icons.block),
                  const SizedBox(width: 8),
                  _buildNavButton("Formatos", MenuOption.formats,
                      icon: Icons.layers),
                  const Spacer(),
                  // Right: Deck Builder (disabled)
                  _buildNavButton("Deck Builder", MenuOption.deckBuilder,
                      disabled: true, icon: Icons.build_circle),
                ],
              ),
        toolbarHeight: 70,
      ),
      body: content,
    );
  }
}
