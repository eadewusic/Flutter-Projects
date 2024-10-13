import 'package:flutter/material.dart';

void main() {
  runApp(const MyTheme());
}

class MyTheme extends StatelessWidget {
  const MyTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalogue w/ Animation',
      theme: ThemeData(
        primarySwatch: Colors.brown, // Using brown color as primary color/theme
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: Colors.black,
      ),
      themeMode: ThemeMode.dark,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
