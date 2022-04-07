import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage_flutter/profilepage.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Image App Demo',
      theme: ThemeData(primaryColor: const Color(0xff476cfb)),
      home: const ProfilePage(),
    );
  }
}
