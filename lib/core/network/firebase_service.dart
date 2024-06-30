// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// // enum('claim','approval','form','reimbursement')
//
// enum NotificationType {
//   claim,
//   approval,
//   form,
//   reimbursement,
// }
//
// //data: {
// //         screen: `${claim.type}`,
// //         id: `${claim.id}`,
// // },
//
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   Map<String, dynamic> notificationMap = {
//     'title': message.notification?.title,
//     'body': message.notification?.body,
//     'data': message.data,
//   };
//   NotificationNavigate.actionWhenClickNotification(notification: notificationMap);
// }
//
// class FirebaseService {
//   final FirebaseRemoteConfig _firebaseRemoteConfig = FirebaseRemoteConfig.instance;
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   static int index = 0;
//   static Map<String, dynamic> notificationMap = {};
//   static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
//   Future<UpdateState> getRemoteConfig() async {
//     await _firebaseRemoteConfig.fetchAndActivate();
//     await _firebaseRemoteConfig.setConfigSettings(
//       RemoteConfigSettings(
//         fetchTimeout: const Duration(seconds: 1),
//         minimumFetchInterval: const Duration(seconds: 1),
//       ),
//     );
//     final int remoteVersionApp = _firebaseRemoteConfig.getInt('last_app_ver');
//     final bool isForceUpdate = _firebaseRemoteConfig.getBool('is_force_update');
//     final bool isRepairApp = _firebaseRemoteConfig.getBool('is_repair_app');
//     const int currentVersionApp = Constants.appVersionNumber;
//     if (isRepairApp) {
//       return UpdateState.repairing;
//     } else {
//       if (remoteVersionApp > currentVersionApp) {
//         if (isForceUpdate) {
//           return UpdateState.forceUpdate;
//         } else {
//           return UpdateState.optionalUpdate;
//         }
//       } else {
//         return UpdateState.noUpdate;
//       }
//     }
//   }
//
//   Future<dynamic> getFcmToken() async {
//     if (Platform.isIOS) {
//       final token = await _firebaseMessaging.getAPNSToken();
//       return token;
//     }
//     final token = await _firebaseMessaging.getToken();
//     return token;
//   }
//
//   static Future<void> initNotifications() async {
//     final firebaseMessaging = FirebaseMessaging.instance;
//     await firebaseMessaging.requestPermission(
//       alert: true,
//       announcement: false,
//       badge: true,
//       carPlay: false,
//       criticalAlert: false,
//       provisional: false,
//       sound: true,
//     );
//     firebaseMessaging.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     const initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_notification_app');
//     const initializationSettingsIos = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );
//     var initializationSettings = const InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIos,
//     );
//     flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (x) {
//         NotificationNavigate.actionWhenClickNotification(notification: notificationMap);
//       },
//     );
//
//     FirebaseMessaging.onMessage.listen(_firebaseMessagingOnMessageHandle);
//     FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingBackgroundHandler);
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//     final x = await FirebaseMessaging.instance.getInitialMessage();
//     if (x != null) {
//       _firebaseMessagingBackgroundHandler(x);
//     }
//   }
//
//   static _firebaseMessagingOnMessageHandle(RemoteMessage message) async {
//     if (!(await freshchat.Freshchat.isFreshchatNotification(message.data))) {
//       const AndroidNotificationChannel channel = AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'High Importance Notifications', // title
//         description: 'This channel is used for important notifications.', // description
//         importance: Importance.max,
//       );
//       notificationMap = {
//         'title': message.notification?.title,
//         'body': message.notification?.body,
//         'data': message.data,
//       };
//
//       flutterLocalNotificationsPlugin.show(
//         index++,
//         message.notification?.title ?? "",
//         message.notification?.body ?? "",
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//           ),
//         ),
//         payload: json.encode(message.data),
//       );
//     }
//   }
// }
//
// class NotificationNavigate {
//   static void actionWhenClickNotification({
//     required Map<String, dynamic> notification,
//   }) {
//     final context = navigatorKey!.currentState!.context;
//     if (notification['data']['screen'] == 'approval') {
//       final approvalId = num.parse(notification['data']['id']);
//
//       Navigator.pushNamed(context, Routes.approvalDetailsRoute, arguments: {
//         'approvalId': approvalId,
//       });
//     }
//
//     // if (notification.data?.action == "accept_auction_second_place") {
//     //   AcceptSecondPlaceScreen.navigate(
//     //       context, AcceptSecondPlaceScreenParams(notificationModel: notification));
//     // } else if (notification.data?.action == "orders") {
//     //   OrderDetailsScreen.navigate(
//     //     context,
//     //     OrderDetailsScreenParams(
//     //       orderId: notification.data?.actionId ?? 0,
//     //     ),
//     //   );
//     // }
//   }
// }
