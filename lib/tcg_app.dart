import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/controllers/main_controller.dart';

class TcgApp extends StatelessWidget {
  const TcgApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premier Mitológico',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.parchment,
        primaryColor: AppColors.forestDark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.forestDark,
          primary: AppColors.forestDark,
          secondary: AppColors.gold,
          error: AppColors.crimson,
          surface: AppColors.parchment,
        ),
        fontFamily:
            'Georgia', // Usamos serif por defecto para el toque "Fantasy"
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.forestDark,
          foregroundColor: AppColors.gold,
          centerTitle: true,
        ),
      ),
      home: const MainController(),
    );
  }
}
