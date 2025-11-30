import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:myl_app_web/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/info_section.dart';
import '../../services/markdown_content_service.dart';

class PrizesAndFundingContent extends StatelessWidget {
  const PrizesAndFundingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: MarkdownContentService.loadContent(
        section: InfoSection.prizesAndFunding,
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
          builders: {
            'code': CodeElementBuilder(),
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
            h4: const TextStyle(
              color: AppColors.beige,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            h4Padding: const EdgeInsets.only(top: 12, bottom: 8),
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
            blockquote: const TextStyle(color: AppColors.coalGrey),
            code: const TextStyle(
              color: AppColors.beige,
              backgroundColor: Colors.transparent,
            ),
            codeblockDecoration: const BoxDecoration(
              color: Colors.transparent,
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

class CodeElementBuilder extends MarkdownElementBuilder {
  @override
  Widget? visitElementAfter(element, preferredStyle) {
    final String textContent = element.textContent;

    return _CopyableCodeBlock(text: textContent);
  }
}

class _CopyableCodeBlock extends StatefulWidget {
  final String text;

  const _CopyableCodeBlock({required this.text});

  @override
  State<_CopyableCodeBlock> createState() => _CopyableCodeBlockState();
}

class _CopyableCodeBlockState extends State<_CopyableCodeBlock> {
  bool _copied = false;

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.text));
    setState(() {
      _copied = true;
    });

    // Reset back to "Copiar" after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _copied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.coalGrey,
        border: Border.all(color: AppColors.ocher, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Copy button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _copyToClipboard,
                icon: Icon(
                  _copied ? Icons.check : Icons.copy,
                  size: 16,
                ),
                label: Text(_copied ? '¡Copiado!' : 'Copiar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.sageGreen,
                  foregroundColor: AppColors.coalGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  textStyle: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          // Selectable code text
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SelectableText(
              widget.text,
              style: const TextStyle(
                color: AppColors.beige,
                fontSize: 14,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
