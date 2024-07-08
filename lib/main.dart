import 'package:flutter/material.dart';
import 'package:rb_image_bucket/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
