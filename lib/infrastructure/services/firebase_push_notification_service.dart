import 'dart:convert';
import 'package:http/http.dart' as http;

class FirebasePushNotificationService {

  FirebasePushNotificationService();

  Future<void> sendNotification(String title, String body, List<String> tokens) async {

    final data = {
      'message': {
        'token': tokens, 
        'notification': {
          'title': title,
          'body': body,
        },
      },
    };

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer f02qBltYQqifAxLajtYV4U:APA91bGie3oDBOjF-nbKqg-8twmvthpGi9-KLdCBGRHUPvphi1k70N4mylFzKT_ea2ZxzJVGhEMUMFjnjhMGbkYoxiKCvbkpy83gM7F9gNzY5XI5Vc2ehANsAua4BcIUdyGLGAnW7YeS',
    };

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/v1/projects/director-2024-redencion/messages:send'),
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print('Notificación enviada exitosamente');
    } else {
      print('Error al enviar la notificación: ${response.body}');
    }
  }
}