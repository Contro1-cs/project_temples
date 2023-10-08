import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_temples/home.dart';
import 'package:project_temples/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

bool userBool = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      userBool = false;
    } else {
      userBool = true;
    }
  });
  runApp(const MyApp());
}

Color darkGreen = const Color(0xff447604);
Color lightGreen = const Color(0xffBBDB9B);
Color bgGreen = const Color(0xffF4FFE9);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temple Quest',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: userBool ? const HomePage() : const LandingPage(),
    );
  }
}
