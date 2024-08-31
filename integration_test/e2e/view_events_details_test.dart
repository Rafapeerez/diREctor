import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:director_app_tfg/main.dart' as app;

//In order to pass this test, the user must accept the permissions and choose an email account.

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  group('end-to-end', () {
    testWidgets('View Events Details', (WidgetTester tester) async {

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Finder googleLoginButton = find.text('Inicia sesión con Google');

      await tester.tap(googleLoginButton);
      await tester.pumpAndSettle();

      final Finder concertCard = find.text('Concierto');
      await tester.tap(concertCard);
      await tester.pumpAndSettle();


      final Finder datePanel = find.text('Día y Hora');
      await tester.tap(datePanel);
      await tester.pumpAndSettle();
      await tester.tap(datePanel);
      await tester.pumpAndSettle();


      final Finder durationPanel = find.text('Duración');
      await tester.tap(durationPanel);
      await tester.pumpAndSettle();


      final Finder repertoirePanel = find.text('Repertorio');
      await tester.tap(repertoirePanel);
      await tester.pumpAndSettle();


      expect(find.text('Día y Hora'), findsOneWidget);
      expect(find.text('Duración'), findsOneWidget);
      expect(find.text('Repertorio'), findsOneWidget);
      expect(find.text('Notas'), findsOneWidget);
    });
  });
}
