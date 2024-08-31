import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:director_app_tfg/main.dart' as app;

void main() async {
  // Initialize the integration test environment
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await FlutterConfig.loadEnvVariables();

  group('end-to-end', () {
    testWidgets('View March Details', (WidgetTester tester) async {
      
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      // Find the Google login button and simulate a tap
      final Finder googleLoginButton = find.text('Inicia sesión con Google');
      await tester.tap(googleLoginButton);
      await tester.pumpAndSettle();

      // Find the "Marchas" button and tap it to go to the list of marches
      final Finder holyWeekButton = find.text('Marchas');
      await tester.tap(holyWeekButton);
      await tester.pumpAndSettle();

      final Finder marchItem = find.text('Military Escort');

      // Scroll the ListView until the march item is visible
      await tester.dragUntilVisible(
        marchItem,               
        find.byType(ListView),   // The widget that contains the scrollable content
        const Offset(0, -300),   
      );

      // Tap the march item to open its details
      await tester.tap(marchItem);
      await tester.pumpAndSettle();
      
      // Verify that the march details are displayed correctly
      expect(find.text('Autor'), findsOneWidget);              
      expect(find.text('Más Información'), findsOneWidget);   
    });
  });
}
