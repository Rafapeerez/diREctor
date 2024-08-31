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
    testWidgets('Profile View', (WidgetTester tester) async {

      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final Finder googleLoginButton = find.text('Inicia sesión con Google');
      await tester.tap(googleLoginButton);
      await tester.pumpAndSettle();

      final Finder avatarFinder = find.byWidgetPredicate(
        (Widget widget) {
          if (widget is IconButton) {
            final Widget icon = widget.icon;
            if (icon is CircleAvatar) {
              return true;
            }
          }
          return false;
        },
      );

      expect(avatarFinder, findsOneWidget);

      await tester.tap(avatarFinder);
      await tester.pumpAndSettle();

      expect(find.text('Perfil'), findsOneWidget);
    });
  });
}
