import 'dart:io';
import 'package:dating_app/authenticationScreen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dating_app/controllers/authentication_controllers.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  Platform.isAndroid
      ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAqcAd9PW1npLt6DVXxRihCQF9zC9x1gIw",
        appId: "1:836354053617:android:ac393b96ce09d18ae3e050",
        messagingSenderId: "836354053617",
        projectId: "dating-app-d737c",
        storageBucket: 'dating-app-d737c.appspot.com'
    ),

  )

  :await Firebase.initializeApp().then((value)

  {
    Get.put(AuthenticationController());
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialBinding: BindingsBuilder(() {
            Get.put(AuthenticationController());
        }),
        title: 'Dating App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
        ),

      debugShowCheckedModeBanner: false,

      home: LoginScreen(),
    );
  }
}

