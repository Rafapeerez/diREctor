import 'package:director_app_tfg/config/theme/theme.dart';
import 'package:director_app_tfg/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:director_app_tfg/config/router/router.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(const MainApp());
  runApp(const ProviderScope(child: MainApp()));

}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) { 
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}

// class MaterialAppWithTheme extends StatelessWidget {
//   const MaterialAppWithTheme({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Provider.of<AppTheme>(context);

//     return MaterialApp.router(
//         routerConfig: appRouter,
//         debugShowCheckedModeBanner: false,
//         theme: theme.getTheme());
//   }
// }
