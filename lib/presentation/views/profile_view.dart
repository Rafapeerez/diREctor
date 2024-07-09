import 'package:director_app_tfg/domain/models/musician.dart';
import 'package:director_app_tfg/infrastructure/services/google_services.dart';
import 'package:director_app_tfg/presentation/providers/musician/musician_provider.dart';
import 'package:director_app_tfg/presentation/providers/user_provider.dart';
import 'package:director_app_tfg/presentation/widgets/components/custom_submit_and_cancel_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final userState = ref.watch(userProvider);
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 300, 
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: colors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Perfil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.logout_outlined,
                          color: Colors.white, 
                          size: 25
                        ),
                        onPressed: () async {
                          await GoogleServices.signOut();
                          context.go("/");
                        }
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (userState.user != null && userState.user?.photoURL != null)
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(userState.user!.photoURL!),
                    ),
                ],
              ),
            ),
          ),
          _TextField(title: 'Nombre Completo', value: userState.user!.displayName),
          _TextField(title: 'Email', value: userState.user!.email),
          _TextField(title: 'Instrumento', value: userState.instrument),
          _TextField(
            title: 'Teléfono', 
            value: userState.phoneNumber,
            isEditable: true,
          ),
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  
  final String title;
  final String? value;
  final bool isEditable;

  const _TextField({
    required this.title, 
    required this.value,
    this.isEditable = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Row(
            children: [
              Text(
                "$title:", 
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )
              ),
              const Spacer(),
              isEditable 
                ? IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          title: Text('Número de teléfono'),
                          content: _TelephoneForm(),
                        );
                      }
                    );
                  },
                  color: Colors.black,
                )
                : const SizedBox()
            ],
          ),
          const SizedBox(height: 5),
          Text(
            value ?? "-", 
            style: const TextStyle(
              fontSize: 14,
            )
          ),
          const SizedBox(height: 15)
        ],
      ),
    );
  }
}

class _TelephoneForm extends ConsumerStatefulWidget {
  

  const _TelephoneForm();

  @override
  _TelephoneFormState createState() => _TelephoneFormState();
}

class _TelephoneFormState extends ConsumerState<_TelephoneForm> {
  final _formKey = GlobalKey<FormState>();
  String _telephoneNumber = "";

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userProvider);
    final musicianProv = ref.read(musicianProvider.notifier);
    
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            //FORM
            //PHONE NUMBER
            TextFormField(
              initialValue: userState.phoneNumber,
              maxLength: 9,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ingresa el número de teléfono',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingresa el número de teléfono';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  setState(() {
                    _telephoneNumber = value;
                  });
                });
              },
            ),
            const SizedBox(height: 16),
            
            SubmitAndCancelButtons(
              onCancelPressed: () => Navigator.of(context).pop(), 
              onSubmitedPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (userState.user != null) {
                    await musicianProv.getMusicianById(userState.user!.email!);
                    final musician = ref.watch(musicianProvider);
                    await musicianProv.updateMusician(
                      Musician(
                        email: userState.user!.email!, 
                        name: userState.user!.displayName!,
                        instrument: userState.instrument, 
                        isAllowed: musician!.isAllowed, 
                        fcm: userState.fcm,
                        isAdmin: userState.isAdmin,
                        phoneNumber: _telephoneNumber,
                        totalEventsAttendance: musician.totalEventsAttendance
                      )
                    );
                    ref.watch(userProvider.notifier).updatePhoneNumber(_telephoneNumber);
                    Navigator.of(context).pop();
                  }
                  Navigator.of(context).pop();
                }                  
              },
            )
          ],
        ),
      ),
    );
  }
}