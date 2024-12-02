import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/country_provider.dart';
import 'providers/compare_provider.dart'; 
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

// MyApp is the root widget of the application.
class MyApp extends StatelessWidget {
  const MyApp(
      {super.key});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider to inject multiple providers into the widget tree
    return MultiProvider(
      providers: [
        // Providing CountryProvider to manage state related to countries
        ChangeNotifierProvider(create: (_) => CountryProvider()),

        // Providing CompareProvider to manage state for comparing countries
        ChangeNotifierProvider(create: (_) => CompareProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false, // Disabling the debug banner for a cleaner UI in non-debug mode
        title: 'Country App',
        theme: ThemeData(
          primarySwatch:
              Colors.blue, // Setting the app's primary color theme to blue
        ),
        home:
            const HomeScreen(),
      ),
    );
  }
}
