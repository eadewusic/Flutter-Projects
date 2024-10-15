import 'package:flutter/material.dart';
import 'theme.dart'; // Import theme file
import 'product.dart'; // Import product file

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  bool isDarkMode = false; // Track dark mode state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Store',
      theme: isDarkMode
          ? MyThemes.darkTheme
          : MyThemes.lightTheme, // Switch between themes
      home: CatalogPage(
        isDarkMode: isDarkMode,
        toggleTheme: toggleTheme,
      ),
    );
  }

  // Function to toggle between light and dark mode
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode; // Toggle theme state
    });
  }
}

// Catalog page with a custom toggle switch
class CatalogPage extends StatelessWidget {
  final bool isDarkMode; // Track if dark mode is enabled
  final Function toggleTheme; // Function to toggle theme

  const CatalogPage(
      {super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal, // Set AppBar to teal color
        title: Text('Flutter Store'),
        actions: [
          Row(
            children: [
              // Sun and Moon icons based on the current theme
              Icon(isDarkMode ? Icons.nights_stay : Icons.wb_sunny,
                  color: Colors.white),
              Switch(
                value: isDarkMode,
                onChanged: (value) => toggleTheme(),
                activeColor: Colors.white, // Thumb color when active
                inactiveThumbColor: Colors.grey, // Grey thumb when inactive
                inactiveTrackColor:
                    Colors.grey[300], // Grey track when inactive

                // Update the dark mode switch to have better visibility
                activeTrackColor:
                    Colors.teal[700], // Darker teal track for visibility
              ),
            ],
          ),
        ],
      ),
      body: ProductGrid(), // Product grid
    );
  }
}

// ProductGrid widget displays a grid of product cards
class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  ProductGridState createState() => ProductGridState();
}

// State class for ProductGrid
class ProductGridState extends State<ProductGrid> {
  // Opacity value for all products, initially set to fully opaque
  double opacity = 1.0;

  // Method to handle tapping on a product
  void _handleTap(BuildContext context, Product product) {
    setState(() {
      // Toggle opacity between 1.0 (fully opaque) and 0.5 (semi-transparent)
      opacity = opacity == 1.0 ? 0.5 : 1.0;
    });
    // Hide any existing SnackBar
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    // Show a new SnackBar with the tapped product's name
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product Tapped: ${product.name}'),
        duration: Duration(seconds: 5), // SnackBar visible for 5 seconds
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            // Hide the SnackBar when 'DISMISS' is tapped
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            setState(() {
              // Reset opacity to fully opaque
              opacity = 1.0;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // Configure the grid layout
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        childAspectRatio: 0.75, // Aspect ratio of each grid item
        crossAxisSpacing: 10, // Horizontal spacing between items
        mainAxisSpacing: 10, // Vertical spacing between items
      ),
      itemCount: products.length, // Number of products to display
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () => _handleTap(context, product), // Handle tap on product
          child: AnimatedOpacity(
            duration: Duration(seconds: 1), // Animation duration
            opacity: opacity, // Current opacity value
            child: Card(
              elevation: 4, // Card shadow
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.contain, // Fit image within available space
                      ),
                    ),
                    SizedBox(height: 8), // Spacing
                    Text(
                      product.name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      maxLines: 2, // Limit to 2 lines
                      overflow: TextOverflow
                          .ellipsis, // Show ellipsis if text overflows
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4), // Spacing
                    Text(
                      '\$${product.price.toStringAsFixed(2)}', // Format price to 2 decimal places
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
