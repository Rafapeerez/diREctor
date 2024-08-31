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
    testWidgets('View Holy Week Events Details', (WidgetTester tester) async {

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Finder googleLoginButton = find.text('Inicia sesión con Google');
      await tester.tap(googleLoginButton);
      await tester.pumpAndSettle();

    
      final Finder holyWeekButton = find.text('Semana Santa');
      await tester.tap(holyWeekButton);
      await tester.pumpAndSettle();

      final Finder mondayCard = find.text('Lunes Santo');
      await tester.scrollUntilVisible(
        mondayCard,
        500.0,  
        scrollable: find.byType(Scrollable),
      );  
      await tester.tap(mondayCard);
      await tester.pumpAndSettle();
      
      expect(find.text('Día y Hora'), findsOneWidget);
      expect(find.text('Duración'), findsOneWidget);
    });
  });
}
