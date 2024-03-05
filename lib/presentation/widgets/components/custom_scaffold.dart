import 'package:director_app_tfg/presentation/views/menu_view.dart';
import 'package:director_app_tfg/presentation/views/profile_view.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_appbar.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey),
      drawer: const MenuView(),
      endDrawer: const ProfileView(),
      body: body,
    );
  }
}
