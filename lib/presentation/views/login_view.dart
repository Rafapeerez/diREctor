import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/services/google_services.dart';
import 'package:director_app_tfg/presentation/providers/musician/musician_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    _initNotifications();
  }

  Future<void> _initNotifications() async {
    // Request permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      // Get the token
      String? token = await _firebaseMessaging.getToken();
      print('FCM Token: $token');

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Received a message while in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print('Message also contained a notification: ${message.notification}');
        }
      });

      // Handle messages that opened the app from a terminated state
      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
        if (message != null) {
          print('Message also contained a notification: ${message.notification}');
        }
      });

      // Handle messages that opened the app from a background state
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print('Message opened from background state: ${message.notification}');
      });

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
    } else {
      print('User declined or has not accepted permission');
    }
  }

  static Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }

  Future<void> subscribeToTopic() async {
    await _firebaseMessaging.subscribeToTopic('events');
  }

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
          ],
        )
      ])
    );
  }
}
class _LogInButton extends ConsumerStatefulWidget {
  final GoogleServices googleServices = GoogleServices();

  @override
  _LogInButtonState createState() => _LogInButtonState();
}

class _LogInButtonState extends ConsumerState<_LogInButton> {
  bool _isLoading = false;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final musicianProv = ref.read(musicianProvider.notifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton.icon(
          icon: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Container(
              color: Colors.white,
              child: Image.asset(
                'lib/config/assets/images/SignInGoogle.png',
                width: size.width * 0.1,
              ),
            ),
          ),
          label: const Text(
            'Inicia sesión con Google',
            style: TextStyle(
              color: Colors.white
            ),
          ),
          onPressed: () async {
            setState(() {
              _isLoading = true;
            });
            User? user = await widget.googleServices.signInWithGoogle();
            if (context.mounted && user != null) {
              await musicianProv.getMusicianById(user.email!);
              final musician = ref.watch(musicianProvider);
              if (musician != null) {
                if (musician.isAllowed == true) {
                  ref.read(userProvider.notifier).signIn(user, musician.isAdmin, musician.instrument);
                  context.go("/home/0");
                } else {
                  context.go('/waiting-screen');
                }
              } else {
                String? token = await _messaging.getToken();
                final createdMusician = Musician.create(
                  email: user.email!,
                  name: user.displayName ?? "",
                  isAllowed: false,
                  isAdmin: false,
                  fcm: token ?? ""
                );
                await musicianProv.saveMusician(createdMusician);
                await context.findAncestorStateOfType<_LogInViewState>()?.subscribeToTopic();
                context.go('/waiting-screen');
              }
            }
            setState(() {
              _isLoading = false;
            });
          },
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.fromLTRB(3, 3, 12, 3),
            backgroundColor: colors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        if (_isLoading) 
          const Column(
            children: [
              SizedBox(height: 16.0),
              CircularProgressIndicator(strokeWidth: 3)
            ],
          )
      ],
    );
  }
}