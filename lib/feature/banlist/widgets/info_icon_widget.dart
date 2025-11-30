import 'package:flutter/material.dart';
import 'package:myl_app_web/app_colors.dart';

class InfoIconWidget extends StatelessWidget {
  const InfoIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message:
          'Para todos los formatos, no se pueden incluir en el mazo:\n- Las cartas de Aliado sin raza\n- Las cartas con "SP" en su nombre.\n- Las cartas con ★ en su nombre.\n\nLas imagenes usadas son referenciales y pueden o no corresponder a la última versión impresa de la carta.\n\nLas siguientes restricciones aplican a cualquier versión de la carta.',
      preferBelow: true,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.beige,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.ocher, width: 1),
      ),
      textStyle: const TextStyle(
        color: AppColors.coalGrey,
        fontSize: 14,
      ),
      waitDuration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () {
          // For mobile, show a dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppColors.coalGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: AppColors.ocher, width: 2),
              ),
              title: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppColors.ocher),
                  SizedBox(width: 8),
                  Text(
                    'Información',
                    style: TextStyle(color: AppColors.beige),
                  ),
                ],
              ),
              content: const Text(
                'Para todos los formatos, no se pueden incluir en el mazo:\n- Las cartas de Aliado sin raza\n- Las cartas con "SP" en su nombre.\n- Las cartas con ★ en su nombre.\n\nLas imagenes usadas son referenciales y pueden o no corresponder a la última versión impresa de la carta.\n\nLas siguientes restricciones aplican a cualquier versión de la carta.',
                style: TextStyle(
                  color: AppColors.beige,
                  fontSize: 14,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cerrar',
                    style: TextStyle(color: AppColors.ocher),
                  ),
                ),
              ],
            ),
          );
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.ocher.withAlpha(50),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline,
              color: AppColors.petrolBlue,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }
}
