import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/format_section.dart';
import '../../services/markdown_content_service.dart';

class PrimerBloqueContent extends StatelessWidget {
  const PrimerBloqueContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: MarkdownContentService.loadContent(
        section: FormatSection.primerBloque,
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
          selectable: true,
          onTapLink: (text, href, title) {
            if (href != null) {
              launchUrl(Uri.parse(href));
            }
          },
          styleSheet: MarkdownStyleSheet(
            p: const TextStyle(color: AppColors.beige, fontSize: 16),
            pPadding: const EdgeInsets.only(bottom: 12),
            h1: const TextStyle(
              color: AppColors.beige,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            h1Padding: const EdgeInsets.only(top: 16, bottom: 12),
            h2: const TextStyle(
              color: AppColors.beige,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            h2Padding: const EdgeInsets.only(top: 20, bottom: 10),
            h3: const TextStyle(
              color: AppColors.beige,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            h3Padding: const EdgeInsets.only(top: 16, bottom: 8),
            listBullet: const TextStyle(color: AppColors.ocher),
            listIndent: 24,
            blockSpacing: 16,
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
            tableHead: const TextStyle(
              color: AppColors.beige,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tableBody: const TextStyle(
              color: AppColors.beige,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
