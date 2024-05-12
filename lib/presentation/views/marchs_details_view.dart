import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/presentation/providers/march/march_provider.dart';
import 'package:flutter/material.dart';
import 'package:director_app_tfg/presentation/widgets/custom_expansion_panel.dart';
import 'package:director_app_tfg/presentation/widgets/videos/march_videos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarchsDetailsView extends ConsumerWidget {
  const MarchsDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    March march = ref.read(selectedMarchProvider.notifier).state;

    return ListView(
      children: [
        _CustomTitleSection(title: march.name, number: march.number),
        const SizedBox(height: 10),
        CustomExpansionPanel(headerText: 'Autor', expandedText: march.author),
        CustomExpansionPanel(headerText: 'Más Información', expandedText: march.moreInformation ?? ""),
        const SizedBox(height: 10),
        MarchVideo(youtubeLink: march.link ?? "",name: march.name)
      ],
    );
  }
}

class _CustomTitleSection extends StatelessWidget {
  final String title;
  final int number;

  const _CustomTitleSection({
    required this.title, 
    required this.number
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Text(title, style: const TextStyle(fontSize: 25)),
            const Spacer(),
            Text(
              "Nº $number",
              style: const TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}
