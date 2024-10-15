import 'package:flutter/material.dart';
import 'theme.dart'; // Import the theme class to manage light and dark themes
import 'product.dart'; // Import product file to handle product details

// Main entry point of the application
void main() {
  runApp(MyApp());
}

// MyApp widget manages the state of the theme (dark/light mode)
class MyApp extends StatefulWidget {
  const MyApp({super.key}); // Constructor

  @override
  MyAppState createState() =>
      MyAppState(); // Creates the mutable state for MyApp
}

// State class for MyApp, responsible for managing the app's theme
class MyAppState extends State<MyApp> {
  bool isDarkMode = false; // Boolean to track if dark mode is active

  @override
  Widget build(BuildContext context) {
    // Builds the app with MaterialApp and applies the selected theme
    return MaterialApp(
      title: 'Flutter Store', // Sets the title of the app
      theme: isDarkMode
          ? MyThemes.darkTheme
          : MyThemes.lightTheme, // Applies theme based on isDarkMode
      home: CatalogPage(
          toggleTheme: toggleTheme), // The home screen is the CatalogPage
    );
  }

  // Function to toggle between light and dark mode
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode; // Switch between true and false
    });
  }
}

// CatalogPage widget displays the catalog of products and includes a button to toggle themes
class CatalogPage extends StatelessWidget {
  final Function toggleTheme; // Receives the toggleTheme function from MyApp
  const CatalogPage({super.key, required this.toggleTheme}); // Constructor

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the structure for the page with an AppBar and a body
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Store'), // Title of the app in the app bar
        actions: [
          // Button to toggle between light and dark mode
          IconButton(
            icon: Icon(Icons.brightness_6), // Icon for brightness toggle
            onPressed: () =>
                toggleTheme(), // Calls the toggleTheme function when pressed
          )
        ],
      ),
      body: ProductGrid(), // Displays the grid of products
    );
  }
}

// ProductGrid widget displays a grid of product cards
class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key}); // Constructor

  @override
  ProductGridState createState() =>
      ProductGridState(); // Creates the state for ProductGrid
}

// State class for ProductGrid, responsible for displaying and handling interaction with the product grid
class ProductGridState extends State<ProductGrid> {
  double opacity = 1.0; // Controls the opacity of the product cards

  @override
  Widget build(BuildContext context) {
    // GridView.builder dynamically creates a grid of products
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        childAspectRatio: 3 / 2, // Aspect ratio for product cards
        crossAxisSpacing: 10, // Space between columns
        mainAxisSpacing: 10, // Space between rows
      ),
      itemCount: products.length, // Total number of products
      itemBuilder: (context, index) {
        final product =
            products[index]; // Gets the product for the current index

        // GestureDetector to handle taps on the product card
        return GestureDetector(
          onTap: () {
            setState(() {
              // Toggle opacity on tap
              opacity = opacity == 1.0 ? 0.5 : 1.0;
            });

            // Show a SnackBar with the product's name when tapped
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('Product Tapped: ${product.name}'), // SnackBar content
                duration: Duration(
                    seconds: 2), // Duration for which the SnackBar is visible
              ),
            );
          },
          // AnimatedOpacity allows the card to fade in and out based on the opacity value
          child: AnimatedOpacity(
            duration: Duration(seconds: 1), // Duration of the opacity animation
            opacity: opacity, // Current opacity of the card
            child: Card(
              elevation: 4, // Elevation effect for shadow
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center the content in the card
                children: [
                  // Display the product image
                  Image.network(product.imageUrl,
                      height: 100, fit: BoxFit.cover),
                  SizedBox(
                      height: 10), // Spacing between the image and the text
                  // Display the product name in bold text
                  Text(product.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5), // Spacing between the name and price
                  // Display the product price
                  Text('\$${product.price}', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
