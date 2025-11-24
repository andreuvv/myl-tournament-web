import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/static/mock_data.dart';
import 'package:myl_app_web/views/home_view_page.dart';
import 'package:myl_app_web/widgets/app_drawer_widget.dart';
import 'package:myl_app_web/widgets/placeholder_widget.dart';

class MainController extends StatefulWidget {
  const MainController({super.key});

  @override
  State<MainController> createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  MenuOption _selectedOption = MenuOption.home;

  // Método para cambiar de página desde el menú
  void _onMenuSelect(MenuOption option) {
    setState(() {
      _selectedOption = option;
    });
    Navigator.pop(context); // Cerrar el Drawer (Hamburguesa)
  }

  @override
  Widget build(BuildContext context) {
    // Selección de la vista basada en el estado actual
    Widget content;
    switch (_selectedOption) {
      case MenuOption.home:
        content = HomeView(tournament: currentTournament);
        break;
      case MenuOption.banList:
        content = const PlaceholderView(title: "Lista de Cartas Prohibidas");
        break;
      case MenuOption.formats:
        content = const PlaceholderView(title: "Formatos de Juego");
        break;
      case MenuOption.info:
        content = const PlaceholderView(title: "Información del Torneo");
        break;
      case MenuOption.deckBuilder:
        content = const PlaceholderView(title: "Constructor de Mazos");
        break;
    }

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
        selectedOption: _selectedOption,
        onSelect: _onMenuSelect,
      ),
      body: content,
    );
  }
}
