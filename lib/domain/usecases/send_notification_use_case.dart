import 'package:director_app_tfg/infrastructure/services/firebase_push_notification_service.dart';

class SendNotificationUseCase {
  final FirebasePushNotificationService _notificationService;

  SendNotificationUseCase(this._notificationService);

  Future<void> sendNotificationToGroup(String title, String body, List<String> tokens) async {
    await _notificationService.sendNotification(title, body, tokens);
  }
}