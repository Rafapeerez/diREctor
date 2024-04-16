import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/', 
  routes: [
    GoRoute(
      path: '/',
      name: LogInScreen.name,
      builder: (BuildContext context, GoRouterState state) => const LogInScreen(),
    ),
    GoRoute(
      path: '/waiting-screen',
      name: WaitingScreen.name,
      builder: (BuildContext context, GoRouterState state) => const WaitingScreen(),
    ),
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.name,
      builder: (context, state) {
        final String pageIndex = state.pathParameters['page'] ?? '0';
        return HomeScreen( pageIndex: int.parse(pageIndex) );
      },
      routes: [
        GoRoute(
          path: 'userlist-screen',
          name: UserListScreen.name,
          builder: (BuildContext context, GoRouterState state) => const UserListScreen(),
        ),
        GoRoute(
          path: "eventsdetails-screen",
          name: EventsDetailsScreen.name,
          builder: (BuildContext context, GoRouterState state) => const EventsDetailsScreen(),
        ),
        GoRoute(
          path: 'marchdetails-screen',
          name: MarchDetailsScreen.name,
          builder: (BuildContext context, GoRouterState state) => const MarchDetailsScreen(),
        ),

        GoRoute(
          path: 'pdfviewer-screen',
          name: PdfViewerScreen.name,
          builder: (BuildContext context, GoRouterState state) => const PdfViewerScreen(),
        ),
      ]
    ),
  ]
);
