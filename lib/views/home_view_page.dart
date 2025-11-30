import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/models/tournament_data_model.dart';
import 'package:myl_app_web/static/mock_data.dart';
import 'package:myl_app_web/feature/countdown_widget/widget/countdown_card_widget.dart';
import 'package:myl_app_web/widgets/map_card_widget.dart';

class HomeView extends StatelessWidget {
  final TournamentData tournament;
  final Function(MenuOption)? onNavigate;

  const HomeView({
    super.key,
    required this.tournament,
    this.onNavigate,
  });

  Widget _buildQuickAccessCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.coalGrey,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.beige,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
              fontSize: 14,
              color: AppColors.beige,
              fontStyle: FontStyle.italic,
            ),
          ),

          const SizedBox(height: 40),

          // Quick access cards
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 800) {
                return Row(
                  children: [
                    Expanded(
                      child: _buildQuickAccessCard(
                        title: 'Fixture del Torneo',
                        subtitle: 'Ver emparejamientos y rondas',
                        icon: Icons.calendar_month,
                        color: AppColors.petrolBlue,
                        onTap: () {
                          // TODO: Navigate to fixture section
                          if (onNavigate != null) {
                            onNavigate!(MenuOption.info);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildQuickAccessCard(
                        title: 'Tabla de Posiciones',
                        subtitle: 'Ver clasificación actual',
                        icon: Icons.emoji_events,
                        color: AppColors.ocher,
                        onTap: () {
                          // TODO: Navigate to standings section
                          if (onNavigate != null) {
                            onNavigate!(MenuOption.info);
                          }
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildQuickAccessCard(
                      title: 'Fixture del Torneo',
                      subtitle: 'Ver emparejamientos y rondas',
                      icon: Icons.calendar_month,
                      color: AppColors.petrolBlue,
                      onTap: () {
                        // TODO: Navigate to fixture section
                        if (onNavigate != null) {
                          onNavigate!(MenuOption.info);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildQuickAccessCard(
                      title: 'Tabla de Posiciones',
                      subtitle: 'Ver clasificación actual',
                      icon: Icons.emoji_events,
                      color: AppColors.ocher,
                      onTap: () {
                        // TODO: Navigate to standings section
                        if (onNavigate != null) {
                          onNavigate!(MenuOption.info);
                        }
                      },
                    ),
                  ],
                );
              }
            },
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
          /* Container(
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
          const SizedBox(height: 40), */
        ],
      ),
    );
  }
}
