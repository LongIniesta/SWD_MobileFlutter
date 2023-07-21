import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';

class FirebaseNotification {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // đại loại thì background - khi mình không xài điện thoại
  // foreground - khi mình xài điện thoại
  // opened app - khi mình mở app?
  // chắc lưu noti vô firebase database ha
  void initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    print(fcmToken);
    initPushNotifications();
  }

  Future<void> handleFirebaseMessagingBackgroundMessage(
      RemoteMessage message) async {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // navigatorKey.currentState?.;
  }

  Future initPushNotifications() async {
    // this is configuration for Apple devices
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    // when open the app from the notification
    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onBackgroundMessage(
        handleFirebaseMessagingBackgroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}

class FirebaseDatabase {}

class FirebaseStorageService {
  static final _firebaseStorageReference = FirebaseStorage.instance.ref();
  static const imageDirectory = 'images';
  static Future<String?> uploadFile(
      {required fileName,
      required String fileDirectory,
      required File file}) async {
    final fileExtention = _getFileExtension(file);
    final storageReference = _firebaseStorageReference.child(fileDirectory);
    final fileReference = storageReference.child('$fileName.$fileExtention');
    final metadata =
        SettableMetadata(contentType: lookupMimeType(fileExtention));
    var taskSnapshot = await fileReference.putFile(file, metadata);
    if (taskSnapshot.state == TaskState.success) {
      return fileReference.fullPath;
    }
    return null;
  }

  static String _getFileExtension(File file) {
    return file.path.split('.').last;
  }

  void deleteFile() {
    final deleteFileStorageReference = _firebaseStorageReference.child('path');
    deleteFileStorageReference.delete();
  }
}
