import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/presentation/providers/march/march_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:director_app_tfg/presentation/widgets/pop_up_menu_buttom.dart';
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
        _CustomTitleSection(march: march, number: march.number),
        const SizedBox(height: 10),
        CustomExpansionPanel(headerText: 'Autor', expandedText: march.author),
        CustomExpansionPanel(headerText: 'Más Información', expandedText: march.moreInformation ?? ""),
        const SizedBox(height: 10),
        MarchVideo(youtubeLink: march.link ?? "", name: march.name)
      ],
    );
  }
}

class _CustomTitleSection extends ConsumerWidget {
  final March march;
  final int number;

  const _CustomTitleSection({
    required this.march, 
    required this.number
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider);

    return Material(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 2, 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                march.name, 
                overflow: TextOverflow.clip,
                style: const TextStyle(fontSize: 25)
              ),
            ),
            const SizedBox(width: 20),
            Text(
              "Nº $number",
              style: const TextStyle(fontSize: 25),
            ),
            if (userState.isAdmin) PopUpMenuButton(marchSelected: march)
            else const SizedBox(width: 20), 
            
          ],
        ),
      ),
    );
  }
}
