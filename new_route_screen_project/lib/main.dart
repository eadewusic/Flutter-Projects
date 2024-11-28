import 'package:flutter/material.dart';
import 'package:new_route_screen_project/screens/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Data Passing App',
      home: FirstScreen(),
    );
  }
}
