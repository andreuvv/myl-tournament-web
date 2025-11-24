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
        scaffoldBackgroundColor: AppColors.coalGrey,
        primaryColor: AppColors.sageGreen,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.sageGreen,
          primary: AppColors.sageGreen,
          secondary: AppColors.ocher,
          error: AppColors.brickRed,
          surface: AppColors.beige,
        ),
        fontFamily:
            'Georgia', // Usamos serif por defecto para el toque "Fantasy"
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.ocher,
          foregroundColor: AppColors.coalGrey,
          centerTitle: true,
        ),
      ),
      home: const MainController(),
    );
  }
}
