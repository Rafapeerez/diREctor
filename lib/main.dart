import 'package:director_app_tfg/config/theme/theme.dart';
import 'package:director_app_tfg/firebase_options.dart';
import 'package:director_app_tfg/presentation/providers/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:director_app_tfg/config/router/router.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTheme appTheme = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'Flutter Widgets',
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      routerConfig: appRouter
    );
  }
}
