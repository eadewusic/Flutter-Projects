import 'package:flutter/material.dart';
import 'main.dart';  // Import the Product class from the first file

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,  // Match the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,  // Bold title with a dark color
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),  // Slightly gray text
            ),
            const SizedBox(height: 16),
            Text(
              'Price: \$${product.price}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.teal,
                fontWeight: FontWeight.bold,  // Price in bold and themed color
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,  // Button color matching the theme
              ),
              onPressed: () {
                Navigator.pop(context);  // Go back to the previous page
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
