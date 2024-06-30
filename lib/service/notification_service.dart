import 'package:firebase_messaging/firebase_messaging.dart';

abstract class NotificationService {
  Future<String?> generateToken();
  Future<void> requestPermission();

  static NotificationService create() {
    return FCMNotificationService();
  }
}

class FCMNotificationService implements NotificationService {
  @override
  Future<String?> generateToken() async {
    return FirebaseMessaging.instance.getToken(
        vapidKey:
            "BEQuHSqa5Tvk95gnIZYkv8oBRZ3sjXEYjEw9AYbjXfG95OX7J_o7oiaaGvDjRlAQHT8gyNMVNPSTHylYC5ifNyM");
  }

  @override
  Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(provisional: true);
  }
}
