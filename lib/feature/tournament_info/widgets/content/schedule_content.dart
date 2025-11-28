import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:myl_app_web/app_colors.dart';
import '../../models/info_section.dart';
import '../../services/markdown_content_service.dart';

class ScheduleContent extends StatelessWidget {
  const ScheduleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: MarkdownContentService.loadContent(
        section: InfoSection.schedule,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.ocher),
          );
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: Text(
              'Error al cargar el contenido',
              style: const TextStyle(color: AppColors.beige, fontSize: 18),
            ),
          );
        }

        return Markdown(
          data: snapshot.data!,
          styleSheet: MarkdownStyleSheet(
            p: const TextStyle(color: AppColors.beige, fontSize: 16),
            h1: const TextStyle(
              color: AppColors.beige,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            h2: const TextStyle(
              color: AppColors.beige,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            h3: const TextStyle(
              color: AppColors.beige,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            listBullet: const TextStyle(color: AppColors.ocher),
            strong: const TextStyle(
              color: AppColors.beige,
              fontWeight: FontWeight.bold,
            ),
            em: const TextStyle(
              color: AppColors.beige,
              fontStyle: FontStyle.italic,
            ),
            blockquote: const TextStyle(color: AppColors.beige),
            code: const TextStyle(
              color: AppColors.ocher,
              backgroundColor: AppColors.coalGrey,
            ),
          ),
        );
      },
    );
  }
}
