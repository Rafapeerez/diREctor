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
  testWidgets('Sign In with Google and redirect to waiting screen', (WidgetTester tester) async {

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Finder googleLoginButton = find.text('Inicia sesión con Google');

      await tester.tap(googleLoginButton);
      await tester.pumpAndSettle();
      
      expect(find.byIcon(Icons.menu), findsNothing);
      expect(find.text("¡¡¡Bienvenido/a!!!"), findsOneWidget);
    });
  });
}