import 'package:bank_pick/Screens/onboarding.dart';
import 'package:bank_pick/shared_preferences/session_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//final scaffoldKey = GlobalKey<ScaffoldState>();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    requestPermission();
    getToken();
    getMytoken();
    initInfo();
    super.initState();
    wait();
  }

  getMytoken() async {
    SessionManager manager = SessionManager();
    var token = await manager.getMessagingToken();
    print(token);
  }

  wait() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const OnboardingScreen(),
      ));
    });
  }

  void requestPermission() async {
    FirebaseMessaging message = FirebaseMessaging.instance;
    NotificationSettings settings = await message.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional authorization');
    } else {
      print('User declined');
    }
  }

  void getToken() async {
    SessionManager manager = SessionManager();
    await FirebaseMessaging.instance.getToken().then((value) {
      print(value);
      manager.saveMessagingToken(value!);
    });
  }

  void initInfo() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) async {
        try {} catch (e) {}
      },
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a foreground notification:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
      displayNotification(message);

      // BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      //     message.notification!.body.toString(),
      //     htmlFormatBigText: true,
      //     contentTitle: message.notification!.title.toString(),
      //     htmlFormatContentTitle: true);

      // AndroidNotificationDetails androidPlatform = AndroidNotificationDetails(
      //     'dbfood', 'dbfood',
      //     importance: Importance.high,
      //     styleInformation: bigTextStyleInformation,
      //     playSound: true);
      // NotificationDetails platformChannel = NotificationDetails(
      //     android: androidPlatform, iOS: const DarwinNotificationDetails());
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('User tapped on the notification:');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
    });

    // Handle the initial notification when the app is launched from a terminated state
    RemoteMessage? initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      print('App launched from a terminated state:');
      print('Title: ${initialMessage.notification?.title}');
      print('Body: ${initialMessage.notification?.body}');
    }
  }

  Future<void> displayNotification(RemoteMessage message) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channel_id',
      'Channel Name',
      importance: Importance.max,
      priority: Priority.high,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: const DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      body: Padding(
        padding: EdgeInsets.only(left: 99.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/splash.png'),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              'BANKPICK',
              style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
