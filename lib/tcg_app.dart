import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/controllers/main_controller.dart';
import 'package:myl_app_web/static/mock_data.dart';
import 'package:myl_app_web/views/main_view.dart';

class TcgApp extends StatefulWidget {
  const TcgApp({super.key});

  @override
  State<TcgApp> createState() => _TcgAppState();
}

class _TcgAppState extends State<TcgApp> {
  late MainController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MainController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleMenuSelect(MenuOption option, BuildContext context) {
    _controller.selectOption(option);
    // Close drawer if open
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premier Mitológico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.coalGrey,
        primaryColor: AppColors.sageGreen,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.sageGreen,
          primary: AppColors.sageGreen,
          secondary: AppColors.ocher,
          error: AppColors.brickRed,
          surface: AppColors.beige,
        ),
        fontFamily: 'Georgia',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.ocher,
          foregroundColor: AppColors.coalGrey,
          centerTitle: true,
        ),
      ),
      home: StreamBuilder<MenuOption>(
        initialData: _controller.selectedOption,
        stream: _controller.selectedOptionStream,
        builder: (context, snapshot) {
          final selectedOption = snapshot.data ?? MenuOption.home;
          return MainView(
            selectedOption: selectedOption,
            onMenuSelect: (option) => _handleMenuSelect(option, context),
            content: _controller.getContentForOption(
              selectedOption,
              (option) => _handleMenuSelect(option, context),
            ),
          );
        },
      ),
    );
  }
}
