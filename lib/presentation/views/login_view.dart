import 'package:flutter/material.dart';
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
              onPressed: () => context.go('/home-screen') 
            )
          ],
        )
      ])
    );
  }
}

class _LogInButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return ElevatedButton.icon(
      icon: ClipRRect(
        borderRadius: BorderRadius.circular(3),
        child: Container(
          color: Colors.white,
          child: Image.asset('lib/config/assets/images/SignInGoogle.png', width: size.width * 0.1)
        ),
      ), 
      label: const Text('Inicia sesión con Google', style: TextStyle(color: Colors.white),),
      onPressed: () => {},   
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