import 'package:director_app_tfg/config/helpers/get_first_letter_from_each_word_of_string_helper.dart';
import 'package:director_app_tfg/domain/models/march.dart';
import 'package:director_app_tfg/presentation/providers/march/march_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:director_app_tfg/presentation/widgets/components/circle_letter.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_elevated_button.dart';
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

  late List<March> filteredSearchMarch; 
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAndLoadEvents();

    searchController.addListener(() {
      filterSearchResults(searchController.text);
    });
  }

  void _checkAndLoadEvents() {
    final marchs = ref.read(marchsProvider);
    final marchsNotifier = ref.read(marchsProvider.notifier);
    if (marchs.isEmpty) {
      marchsNotifier.getAllMarchsOrderByNumber();
    }
    filteredSearchMarch = marchs;
  }

  void showDialogMethod() async {
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

  void filterSearchResults(String query) {
    final marchs = ref.watch(marchsProvider);
    if (query.isEmpty) {
      setState(() {
        filteredSearchMarch = List.from(marchs);
      });
    } else {
      setState(() {
        filteredSearchMarch = marchs.where((item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final marchs = ref.watch(marchsProvider);

    return marchs.isNotEmpty
        ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8,10,8,0),
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: "Buscar",
                  hintText: "Buscar",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  ListView.builder(
                    itemCount: filteredSearchMarch.length,
                    itemBuilder: (context, index) {
                      final march = filteredSearchMarch[index];
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
                      icon: Icons.add,
                      onPressed: () {
                        showDialogMethod();
                      },
                    )
                ]
              ),
            )
          ],
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