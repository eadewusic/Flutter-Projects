import 'package:flutter/material.dart';
import 'product_details.dart';  // Import the second file

void main() {
  runApp(const ProductApp());
}

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Navigation',
      theme: ThemeData(
        primarySwatch: Colors.teal,  // Change the primary color to match the design
      ),
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Pixel 1', description: 'Pixel is the most featureful phone ever', price: 800),
    Product(name: 'Laptop', description: 'Laptop is the most productive development tool', price: 2000),
    Product(name: 'Tablet', description: 'Tablet is the most useful device for meetings', price: 1500),
    Product(name: 'Pendrive', description: 'Pendrive is the smallest storage device', price: 100),
    Product(name: 'Floppy Drive', description: 'Floppy drive is an outdated storage device', price: 20),
  ];

  ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.teal,  // Match the app bar color
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Card(
              elevation: 3,
              child: ListTile(
                title: Text(
                  products[index].name,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),  // Bold and darker color
                ),
                subtitle: Text(
                  'Price: \$${products[index].price}',
                  style: const TextStyle(color: Colors.teal),
                ),
                trailing: const Icon(Icons.arrow_forward, color: Colors.teal),  // Arrow icon matching the theme color
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(product: products[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final int price;

  Product({required this.name, required this.description, required this.price});
}
