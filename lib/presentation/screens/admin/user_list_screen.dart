import 'package:director_app_tfg/presentation/views/admin/user_list_view.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_bottom_navigationbar.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_scaffold.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatelessWidget {
  static const String name = "userlist-screen";

  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: UserListView(),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0),
    ); 
  }
}
