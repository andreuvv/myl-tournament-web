import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/models/tournament_data_model.dart';

class MapCard extends StatelessWidget {
  final TournamentData data;

  const MapCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.parchment,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(Icons.map, color: AppColors.crimson),
                    SizedBox(width: 8),
                    Text(
                      "UBICACIÓN DEL TORNEO",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.forestDark,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  data.locationName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  data.address,
                  style: const TextStyle(color: AppColors.forestLight),
                ),
              ],
            ),
          ),
          // Placeholder del Mapa
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
              image: DecorationImage(
                // Usamos una imagen abstracta de mapa o textura
                image: NetworkImage(
                  "https://media.istockphoto.com/id/1141193250/vector/city-map-seamless-pattern-simple-repetitive-background-vector-illustration.jpg?s=612x612&w=0&k=20&c=1M4c7hM34T2Yj-L8rR_TPl7M3k2F2X6Y6g-6X4Q5Z8o=",
                ),
                fit: BoxFit.cover,
                opacity: 0.6,
              ),
            ),
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Aquí iría la lógica para abrir url_launcher
                  debugPrint("Abrir Google Maps");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.forestDark,
                  foregroundColor: AppColors.gold,
                ),
                icon: const Icon(Icons.open_in_new),
                label: const Text("Ver en Google Maps"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
