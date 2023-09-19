import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:travelapp/firebase_options.dart';
import 'package:travelapp/provider/bottom_bar.dart';

import 'services/sqflite/local_db.dart';
import 'views/screens/screen_splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SQLFlite sqf = SQLFlite();
  sqf.startDatabase;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => BottomNavigationProvider(),
      child: const MyApp(),
    ),
  );}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
        canvasColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : snapshot.hasData
                  ? ScreenSplash(logOrNot: true)
                  : ScreenSplash(logOrNot: false);
        },
      ),
    );
  }
}