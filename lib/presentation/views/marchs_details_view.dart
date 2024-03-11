import 'package:flutter/material.dart';
import 'package:director_app_tfg/presentation/widgets/custom_expansion_panel.dart';
import 'package:director_app_tfg/presentation/widgets/videos/march_videos.dart';

class MarchsDetailsView extends StatelessWidget {
  const MarchsDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return ListView(
        children: const [
          _CustomTitleSection(title: 'Marcha Real', number: 1),
          SizedBox(height: 10),
          CustomExpansionPanel(headerText: 'Autor', expandedText: 'Pacheco'),
          CustomExpansionPanel(headerText: 'Historia', expandedText: ''),
          CustomExpansionPanel(headerText: 'Más Información', expandedText: ''),
          SizedBox(height: 10),
          MarchVideo(youtubeLink: "https://www.youtube.com/watch?v=4BF20CiOHpg",name: "Marcha Real",)
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
