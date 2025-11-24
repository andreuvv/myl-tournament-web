import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/models/tournament_data_model.dart';
import 'package:myl_app_web/static/mock_data.dart';
import 'package:myl_app_web/widgets/countdown_card_widget.dart';
import 'package:myl_app_web/widgets/map_card_widget.dart';

class HomeView extends StatelessWidget {
  final TournamentData tournament;
  final Function(MenuOption)? onNavigate;

  const HomeView({
    super.key,
    required this.tournament,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.petrolBlue),
              borderRadius: BorderRadius.circular(20),
              color: AppColors.sageGreen,
            ),
            child: const Text(
              "PRÓXIMO TORNEO OFICIAL",
              style: TextStyle(
                color: AppColors.coalGrey,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            tournament.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w900,
              color: AppColors.white,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            tournament.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.white,
              fontStyle: FontStyle.italic,
            ),
          ),

          const SizedBox(height: 40),

          // Íconos de secciones principales
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.beige,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.ocher, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.info,
                        color: AppColors.ocher,
                      ),
                      Text("Información del torneo"),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (onNavigate != null) {
                    onNavigate!(MenuOption.banList);
                  }
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.beige,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.ocher, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Icon(
                          Icons.block,
                          color: AppColors.brickRed,
                        ),
                        Text("Ban List Actualizada")
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.beige,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.ocher, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.layers,
                        color: AppColors.petrolBlue,
                      ),
                      Text("Información de formatos")
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          // Grid adaptable: En pantallas grandes lado a lado, en chicas columna
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: CountdownCard(targetDate: tournament.date)),
                    const SizedBox(width: 30),
                    Expanded(child: MapCard(data: tournament)),
                  ],
                );
              } else {
                return Column(
                  children: [
                    CountdownCard(targetDate: tournament.date),
                    const SizedBox(height: 30),
                    MapCard(data: tournament),
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 50),

          // Call To Action
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.coalGrey, AppColors.coalGrey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.ocher, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "¿Tu estrategia está lista?",
                  style: TextStyle(
                    color: AppColors.ocher,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "No entres a la arena sin preparación.",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    if (onNavigate != null) {
                      onNavigate!(MenuOption.deckBuilder);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.brickRed,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: const Icon(Icons.build),
                  label: const Text("IR AL DECK BUILDER"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
