import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

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
          routes: [
            GoRoute(
              path: 'events-screen',
              name: EventsScreen.name,
              builder: (BuildContext context, GoRouterState state) => const EventsScreen(),
            )
          ]
        ),
      ]
    ),
  ]
);
