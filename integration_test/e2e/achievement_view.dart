import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:director_app_tfg/main.dart' as app;

//In order to pass this test, the user must accept the permissions and choose an email account.

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  group('end-to-end', () {
    testWidgets('Achievement View', (WidgetTester tester) async {

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Finder googleLoginButton = find.text('Inicia sesión con Google');
      await tester.tap(googleLoginButton);
      await tester.pumpAndSettle();

    
      final Finder menuButton = find.byIcon(Icons.menu);
      await tester.tap(menuButton);
      await tester.pumpAndSettle();
      
      final Finder achievementButton = find.byIcon(Icons.timeline_outlined);
      await tester.tap(achievementButton);
      await tester.pumpAndSettle();

      expect(find.text('¡¡Estos son tus logros!!'), findsOneWidget);
    });
  });
}
