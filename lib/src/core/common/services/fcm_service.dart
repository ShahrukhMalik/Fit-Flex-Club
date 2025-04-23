import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fit_flex_club/src/core/common/services/local_notification_service.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Update the token to Firestore under `users/{uid}/fcmToken`
  static Future<void> _updateTokenToFirestore(String? token) async {
    final user = _auth.currentUser;
    if (user != null && token != null) {
      try {
        await _firestore.collection('Users').doc(user.uid).update({
          'fcmToken': token,
        });

        if (kDebugMode) {
          print("✅ Token updated in Firestore for UID: ${user.uid}");
        }
      } catch (e) {
        if (kDebugMode) {
          print("❌ Failed to update token in Firestore: $e");
        }
      }
    }
  }

  /// Initializes FCM and sets up all handlers
  static Future<void> initializeFCM() async {
    // Request permissions for iOS
    await _requestPermission();
    if (_isSimulator()) {
      return;
    }

    if (Platform.isIOS) {
      // Wait until APNs token is set
      String? apnsToken;
      int retryCount = 0;
      while (apnsToken == null && retryCount < 10) {
        apnsToken = await _messaging.getAPNSToken();
        print("📱 APNs Token (attempt $retryCount): $apnsToken");
        await Future.delayed(const Duration(milliseconds: 500));
        retryCount++;
      }

      if (apnsToken == null) {
        throw Exception('❌ APNs token is still null after retries.');
      }
    }

    // Get the token
    String? token = await _messaging.getToken();
    if (kDebugMode) {
      print("FCM Token: $token");
    }
    // Update token to Firestore
    await _updateTokenToFirestore(token);
    // Optional: check APNs token (iOS only)
    // Listen for token refresh
    _messaging.onTokenRefresh.listen((newToken) async {
      if (kDebugMode) {
        print("Token Refreshed: $newToken");
      }
      await _updateTokenToFirestore(newToken);
      // Optionally: Send the new token to your server
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print("📲 Foreground Message:");
        _printMessage(message);
      }

      await LocalNotificationService.showNotification(message);
      // Add UI notification or handling logic here
    });

    // Handle background messages (when the app is opened from background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print("📲 App Opened from Background:");
        _printMessage(message);
      }
      await LocalNotificationService.showNotification(message);
      // Handle navigation or action
    });

    // Handle when app is opened from terminated state
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      if (kDebugMode) {
        print("📲 App Launched via Notification:");
        _printMessage(initialMessage);
      }
      await LocalNotificationService.showNotification(initialMessage);
      // Handle navigation or action
    }
  }

  /// Request notification permission for iOS
  static Future<void> _requestPermission() async {
    if (Platform.isIOS) {
      NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        if (kDebugMode) {
          print('🔐 User granted permission');
        }
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('🔐 User granted provisional permission');
      } else {
        print('❌ User declined or has not accepted permission');
      }
    }
  }

  /// Utility function to print message content
  static void _printMessage(RemoteMessage message) {
    print("🔔 Notification Title: ${message.notification?.title}");
    print("📝 Notification Body: ${message.notification?.body}");
    print("📦 Data: ${message.data}");
  }

  /// Get current token manually (optional)
  static Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  static bool _isSimulator() {
    // return Platform.isIOS &&
    //     !Platform.isMacOS &&
    //     Platform.environment.containsKey('SIMULATOR_DEVICE_NAME');
    return false;
  }
}
