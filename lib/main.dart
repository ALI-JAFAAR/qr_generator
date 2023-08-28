// ignore_for_file: avoid_print


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_fonts/google_fonts.dart';
import '/provider/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'firebase_options.dart';
import 'provider/user.dart';
import 'screens/home/home_screen.dart';
Future<void> backnoti(RemoteMessage message)async{
  print(message.notification?.title);
    print(message.notification?.body);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final noti = FirebaseMessaging.instance;
  noti.requestPermission();
  
  final fcmToken = await FirebaseMessaging.instance.getToken();
  
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage msg){});
  FirebaseMessaging.onBackgroundMessage(backnoti);
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  print(" token token token token token token $fcmToken");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AppProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' QR Generator ',
      theme: ThemeData(
        primaryColor: kPrimarycolor,
        textTheme: GoogleFonts.cairoTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}
