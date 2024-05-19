import 'package:director_app_tfg/config/helpers/get_first_letter_from_each_word_of_string_helper.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/presentation/providers/march/march_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:director_app_tfg/presentation/widgets/circle_letter.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_elevated_button.dart';
import 'package:director_app_tfg/presentation/widgets/filter_botton_sheet.dart';
import 'package:director_app_tfg/presentation/widgets/march/form_march.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MarchsView extends ConsumerStatefulWidget {
  const MarchsView({super.key});

  @override
  MarchsViewState createState() => MarchsViewState();
}

class MarchsViewState extends ConsumerState<MarchsView> {

  @override
  void initState() {
    super.initState();
    _checkAndLoadEvents();
  }

  void _checkAndLoadEvents() {
    final marchs = ref.read(marchsProvider);
    final marchsNotifier = ref.read(marchsProvider.notifier);
    if (marchs.isEmpty) {
      marchsNotifier.getAllMarchsOrderByName();
    }
  }

  void showDialogMethod() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Marcha'),
          content: MarchsForm(),
        );
      }
    );
  }

  void showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return const FilterBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final marchs = ref.watch(marchsProvider);

    return marchs.isNotEmpty
        ? Stack(
          children: [
            ListView.builder(
              itemCount: marchs.length,
              itemBuilder: (context, index) {
                final march = marchs[index];
                return Column(
                  children: [
                    _CustomMarch(
                      march: march,
                      letter: GetFirstLetterFromEachWordOfString.getFirstLetterFromEachWordOfString(march.name)
                    ),
                  ],
                );
              },
            ),
            if (userState.isAdmin)
              CustomElevatedButton(
                icon: Icons.more_vert,
                onPressed: () {
                  final RenderBox button = context.findRenderObject() as RenderBox;
                  final Offset buttonPosition = button.localToGlobal(Offset.zero);
                  final double screenHeight = MediaQuery.of(context).size.height;
                  final double screenWidth = MediaQuery.of(context).size.width;
                  final double dx = screenWidth - buttonPosition.dx;
                  final double dy = screenHeight - buttonPosition.dy - 150;
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(dx, dy, 20, 0),
                    items: const [
                      PopupMenuItem(
                        value: 'Añadir',
                        child: Text('Añadir'),
                      ),
                      PopupMenuItem(
                        value: 'Filtrar',
                        child: Text('Filtrar'),
                      ),
                    ],
                    elevation: 8.0,
                  ).then((choice) {
                    if (choice != null) {
                      if (choice == 'Añadir') {
                        showDialogMethod();
                      } else if (choice == 'Filtrar') {
                        showFilterBottomSheet();
                      }
                    }
                  });
                },
              )
            else
              CustomElevatedButton(
                icon: Icons.filter_alt_rounded,
                onPressed: () {
                  showFilterBottomSheet();
                },
              )
          ]
        )
        : Stack(
          children: [
            const Center(
              child: Text(
                "No hay marchas",
                style: TextStyle(color: Colors.grey, fontSize: 22),
              ),
            ),
            if (userState.isAdmin)
              CustomElevatedButton(
                icon: Icons.add,
                onPressed: () async {
                  showDialogMethod();
                },
              )
          ]
        );
  }
}

class _CustomMarch extends ConsumerWidget {
  final March march;
  final String letter;

  const _CustomMarch({
    required this.march, 
    required this.letter
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectedMarchProv = ref.read(selectedMarchProvider.notifier);

    return GestureDetector(
      onTap: () {
        selectedMarchProv.state = march;
        context.go("/home/2/marchdetails-screen");
      },
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                CircleLetter(letter: letter),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    march.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 20),
                const Icon(
                  Icons.arrow_forward_outlined,
                  size: 30,
                )
              ],
            ),
          ),
          const Divider()
        ],
      ),
    );
  }
}