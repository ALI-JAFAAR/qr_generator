// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import '/provider/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'firebase_options.dart';
import 'provider/user.dart';
import 'screens/home/home_screen.dart';

Future<void> backnoti(RemoteMessage message) async {
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
  OneSignal.initialize("e5a3dda9-5c1b-490e-92bc-f7a3b257cef5");
  OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    /// preventDefault to not display the notification
    event.preventDefault();

    /// Do async work

    /// notification.display() to display after preventing default
    event.notification.display();
  });
  OneSignal.Notifications.addClickListener((event) {
    print('NOTIFICATION CLICK LISTENER CALLED WITH EVENT: $event');
  });
  OneSignal.Notifications.requestPermission(true);

  OneSignal.User.pushSubscription.optIn();
  OneSignal.User.pushSubscription.id;

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
