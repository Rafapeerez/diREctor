import 'package:director_app_tfg/presentation/views/achievement_screen.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_bottom_navigationbar.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class AchievementScreen extends StatelessWidget {
  static const String name = 'achievement-screen';

  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hasArrowBack: true,
      body: AchievementView(),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }
}
