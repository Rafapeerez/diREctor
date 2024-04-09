import 'package:director_app_tfg/presentation/views/menu_view.dart';
import 'package:director_app_tfg/presentation/views/profile_view.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_appbar.dart';

import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool hasArrowBack;

  const CustomScaffold({
    super.key,
    required this.body,
    this.hasArrowBack = false, 
    this.bottomNavigationBar,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        scaffoldKey: scaffoldKey,
        hasArrowBack: hasArrowBack,
      ),
      drawer: hasArrowBack ? null : const MenuView(), 
      endDrawer: const ProfileView(),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
