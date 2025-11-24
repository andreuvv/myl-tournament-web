import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myl_app_web/controllers/ban_list_controller.dart';
import 'package:myl_app_web/static/mock_data.dart';
import 'package:myl_app_web/views/ban_list_page.dart';
import 'package:myl_app_web/views/home_view_page.dart';
import 'package:myl_app_web/widgets/placeholder_widget.dart';

class MainController {
  final _selectedOptionController = StreamController<MenuOption>.broadcast();
  MenuOption _selectedOption = MenuOption.home;

  // Sub-controllers
  final BanListController banListController = BanListController();

  // Expose stream for listening
  Stream<MenuOption> get selectedOptionStream =>
      _selectedOptionController.stream;
  MenuOption get selectedOption => _selectedOption;

  // Method to change selected option
  void selectOption(MenuOption option) {
    _selectedOption = option;
    _selectedOptionController.add(_selectedOption);
  }

  // Get content widget for the selected option
  Widget getContentForOption(
      MenuOption option, Function(MenuOption) onNavigate) {
    switch (option) {
      case MenuOption.home:
        return HomeView(
          tournament: currentTournament,
          onNavigate: onNavigate,
        );
      case MenuOption.banList:
        return BanListPage(controller: banListController);
      case MenuOption.formats:
        return const PlaceholderView(title: "Formatos de Juego");
      case MenuOption.info:
        return const PlaceholderView(title: "Información del Torneo");
      case MenuOption.deckBuilder:
        return const PlaceholderView(title: "Constructor de Mazos");
    }
  }

  // Dispose method to clean up stream
  void dispose() {
    _selectedOptionController.close();
    banListController.dispose();
  }
}
