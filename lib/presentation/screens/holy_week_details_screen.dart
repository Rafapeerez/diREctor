import 'package:director_app_tfg/presentation/views/holy_week_details_view.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_bottom_navigationbar.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class HolyWeekDetailsScreen extends StatelessWidget {
  static const String name = 'holyweekdetails-screen';

  const HolyWeekDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      hasArrowBack: true,
      body: HolyWeekDetailsView(), 
      bottomNavigationBar: CustomBottomNavigationBar( currentIndex: 1 )
    );
  }
}
