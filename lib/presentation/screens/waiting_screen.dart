import 'package:director_app_tfg/presentation/views/waiting_view.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  static const String name = "waiting-screen";

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: WaitingView(),
      hasMenuAndProfileDisable: true,
    );
  }
}
