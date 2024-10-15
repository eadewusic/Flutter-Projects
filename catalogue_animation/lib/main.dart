import 'package:flutter/material.dart';
import 'theme.dart'; // Import your theme file
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

// ProductGrid widget remains unchanged
class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  ProductGridState createState() => ProductGridState();
}

class ProductGridState extends State<ProductGrid> {
  Map<int, double> opacities = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < products.length; i++) {
      opacities[i] = 1.0;
    }
  }

  void _handleTap(int index, BuildContext context) {
    final product = products[index];
    setState(() {
      opacities[index] = opacities[index] == 1.0 ? 0.5 : 1.0;
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product Tapped: ${product.name}'),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: 'DISMISS',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            setState(() {
              opacities[index] = 1.0;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () => _handleTap(index, context),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: opacities[index] ?? 1.0,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      product.name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
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
