import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/static/mock_data.dart';
import 'package:myl_app_web/widgets/app_drawer_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.shield, color: AppColors.coalGrey),
            SizedBox(width: 10),
            Text(
              "Premier Mitológico",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(
        selectedOption: selectedOption,
        onSelect: onMenuSelect,
      ),
      body: SelectionArea(child: content),
    );
  }
}
