// Datos estáticos (Mock Data)
import 'package:myl_app_web/models/tournament_data_model.dart';

final currentTournament = TournamentData(
  title: "Copa K&T Diciembre 2025",
  description:
      "Prepara tu mazo para el torneo más esperado del reino. Gloria y premios esperan a los mejores.",
  date: DateTime(2025, 12, 13, 18, 0), // 13 Dic 2025, 18:00 PM
  locationName: "Hogar de los Karens",
  address: "Las Tórtolas 3273, Macul, Santiago",
);

enum MenuOption { home, banList, formats, info, deckBuilder }
