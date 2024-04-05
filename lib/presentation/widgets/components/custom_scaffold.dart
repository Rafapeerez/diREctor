import 'package:director_app_tfg/presentation/views/menu_view.dart';
import 'package:director_app_tfg/presentation/views/profile_view.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_appbar.dart';

import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool hasArrowBack;
  final bool hasMenuAndProfileDisable;

  const CustomScaffold({
    super.key,
    required this.body,
    this.hasArrowBack = false, 
    this.bottomNavigationBar,
    this.hasMenuAndProfileDisable = false
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
      drawer: hasArrowBack || hasMenuAndProfileDisable ? null : const MenuView(), 
      endDrawer: hasMenuAndProfileDisable ? null : const ProfileView(),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
