import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:myl_app_web/models/tournament_data_model.dart';
import 'package:myl_app_web/config/api_keys.dart';
import 'package:web/web.dart' as web;
import 'dart:ui_web' as ui_web;

class MapCard extends StatefulWidget {
  final TournamentData data;

  const MapCard({super.key, required this.data});

  @override
  State<MapCard> createState() => _MapCardState();
}

class _MapCardState extends State<MapCard> {
  late String viewId;

  @override
  void initState() {
    super.initState();
    viewId = 'google-maps-${widget.data.latitude}-${widget.data.longitude}';

    // Register the iframe view
    // ignore: undefined_prefixed_name
    ui_web.platformViewRegistry.registerViewFactory(
      viewId,
      (int _) {
        final iframe = web.HTMLIFrameElement()
          ..style.border = 'none'
          ..src = 'https://www.google.com/maps/embed/v1/place?'
              'key=${ApiKeys.googleMapsApiKey}'
              //'&q=${widget.data.latitude},${widget.data.longitude}'
              '&q=Las Tórtolas 3273, Macul, Santiago'
              '&zoom=16';
        return iframe;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    Icon(Icons.map, color: AppColors.brickRed),
                    SizedBox(width: 8),
                    Text(
                      "UBICACIÓN DEL TORNEO",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.coalGrey,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.data.locationName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  widget.data.address,
                  style: const TextStyle(color: AppColors.coalGrey),
                ),
              ],
            ),
          ),
          // Google Maps Embed
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(14)),
            child: SizedBox(
              height: 200,
              child: HtmlElementView(viewType: viewId),
            ),
          ),
        ],
      ),
    );
  }
}
