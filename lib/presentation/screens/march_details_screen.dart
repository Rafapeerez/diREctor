import 'package:director_app_tfg/presentation/views/marchs_details_view.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_bottom_navigationbar.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class MarchDetailsScreen extends StatelessWidget {
  const MarchDetailsScreen({super.key});

  static const String name = "marchdetails-screen";
  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      hasArrowBack: true,
      body: MarchsDetailsView(), 
      bottomNavigationBar: CustomBottomNavigationBar( currentIndex: 2 )
    );
  }
}
