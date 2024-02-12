import 'package:director_app_tfg/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:director_app_tfg/config/router/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme( ThemeData.dark() ),
      child: const MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final theme = Provider.of<AppTheme>(context);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme()
    );
  }
}
