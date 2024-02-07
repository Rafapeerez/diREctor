import 'package:director_app_tfg/presentation/screens/home_screen.dart';
import 'package:director_app_tfg/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: LogInScreen.name,
      builder: (BuildContext context, GoRouterState state) => const LogInScreen(),
      routes: [
        GoRoute(
          path: 'home-screen',
          name: HomeScreen.name,
          builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
        )
      ]
    ),
  ]
);
