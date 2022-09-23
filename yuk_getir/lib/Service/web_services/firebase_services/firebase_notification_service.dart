
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';



class NotificationService {

  late final FirebaseMessaging firebaseMessaging;

  void notfSettings () async {
    await firebaseMessaging.requestPermission(
      alert:  true,
      sound: true,
      badge: true,
    );
  }
  Future <void> connection() async {
    firebaseMessaging = FirebaseMessaging.instance;
    notfSettings();
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert:  true,
      sound: true,
      badge: true,
    );
    //Bu yapı uygulama açıkken bildirimleri dinler.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
        print("${message.notification?.title}");
    });
    // Bu yapı uygulama arkaplandayken yada kapalıyken de bildirim gelmesini sağlar.
    FirebaseMessaging.onBackgroundMessage(_backGroundMessages);

    firebaseMessaging.getToken().then((value) => log("Token: $value"));
    firebaseMessaging.subscribeToTopic("onlyYukGetir");
  }
  Future<void> _backGroundMessages (RemoteMessage message) async {
    
     print("${message.notification?.title}");
  }
}