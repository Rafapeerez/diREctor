import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/', 
  navigatorKey: navigatorKey,
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
          path: "holyweekdetails-screen",
          name: HolyWeekDetailsScreen.name,
          builder: (BuildContext context, GoRouterState state) => const HolyWeekDetailsScreen(),
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

        GoRoute(
          path: 'achievement-screen',
          name: AchievementScreen.name,
          builder: (BuildContext context, GoRouterState state) => const AchievementScreen(),
        )
      ]
    ),
  ]
);
