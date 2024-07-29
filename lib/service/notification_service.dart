import 'package:firebase_messaging/firebase_messaging.dart';

/// An abstract class representing a notification service.
abstract class NotificationService {
  /// Generates a token for the device to receive notifications.
  Future<String?> generateToken();

  /// Requests permission from the user to receive notifications.
  Future<void> requestPermission();

  /// Creates an instance of the default notification service.
  static NotificationService create() {
    return FCMNotificationService();
  }
}

/// A concrete implementation of the [NotificationService] using Firebase Cloud Messaging (FCM).
class FCMNotificationService implements NotificationService {
  @override
  Future<String?> generateToken() async {
    return FirebaseMessaging.instance.getToken(
        vapidKey:
            "BEQuHSqa5Tvk95gnIZYkv8oBRZ3sjXEYjEw9AYbjXfG95OX7J_o7oiaaGvDjRlAQHT8gyNMVNPSTHylYC5ifNyM");
  }

  @override
  Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
