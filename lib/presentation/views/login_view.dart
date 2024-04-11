import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/services/google_services.dart';
import 'package:director_app_tfg/presentation/providers/musician/musician_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 190),
            Image.asset('lib/config/assets/images/icon.png'),
            const SizedBox(height: 60),
            _LogInButton(),
            FilledButton(
              child: const Text('mOCK'),
              onPressed: () => context.go('/home/0') 
            )
          ],
        )
      ])
    );
  }
}

class _LogInButton extends ConsumerWidget {

  final GoogleServices googleServices = GoogleServices();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    final musicianProv = ref.read(musicianProvider.notifier);

    return ElevatedButton.icon(
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          color: Colors.white,
          child: Image.asset(
            'lib/config/assets/images/SignInGoogle.png', 
            width: size.width * 0.1
          )
        ),
      ), 
      label: const Text(
        'Inicia sesión con Google', 
        style: TextStyle(
            color: Colors.white
          )
        ),
      onPressed: () async {
        User? user = await googleServices.signInWithGoogle();
        if(context.mounted && user != null){
          final musician = Musician.create(
            email: user.email ?? '', 
            name: user.displayName ?? "", 
            surname: "prueab", 
            isAllowed: false, 
            isAdmin: false
          );
          print("holaaaaaaaaa " + musician.toString());
          try {
            await musicianProv.saveMusician(musician);
          } catch (e) {}
          context.go('/waiting-screen');
        }  
      },   
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.fromLTRB(3, 3, 12, 3),
        backgroundColor: colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
      ), 
    );
  }
}