import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/favorites.dart';
import 'screens/favorites_screen.dart';
import 'widgets/product.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          Favorites(), // Provide Favorites model to the widget tree
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Favorites App',
      home: ProductListScreen(), // Set the home screen to ProductListScreen
    );
  }
}

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: Consumer<Favorites>(
        builder: (context, favorites, child) {
          // Show a loading spinner while favorites are being loaded
          if (favorites.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Display an error message if loading favorites failed
          if (favorites.errorMessage != null) {
            return Center(child: Text(favorites.errorMessage!));
          }

          // Display a list of products
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index]; // Get product details
              final productName = product['name'];

              return Card(
                child: ListTile(
                  leading: Image.network(
                      product['imageUrl']), // Display product image
                  title: Text(productName), // Display product name
                  subtitle:
                      Text('\$${product['price']}'), // Display product price
                  trailing: Consumer<Favorites>(
                    builder: (context, favorites, child) {
                      // Check if the product is in the favorites list
                      final isFavorite = favorites.items.contains(productName);
                      return IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite
                              ? Colors.red
                              : null, // Change color if favorite
                        ),
                        onPressed: () {
                          // Add or remove product from favorites when icon is pressed
                          isFavorite
                              ? favorites.removeItem(productName)
                              : favorites.addItem(productName);
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      // Floating Action Button to navigate to the Favorites screen
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.favorite, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const FavoritesScreen()), // Navigate to Favorites screen
          );
        },
      ),
    );
  }
}
