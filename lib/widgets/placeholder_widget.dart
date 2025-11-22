import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

class PlaceholderView extends StatelessWidget {
  final String title;
  const PlaceholderView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.construction, size: 64, color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.forestDark,
            ),
          ),
          const SizedBox(height: 10),
          const Text("Esta sección está bajo construcción mágica."),
        ],
      ),
    );
  }
}
