import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Consumer<Favorites>(
        builder: (context, favorites, child) {
          // Show a loading spinner if the favorites are still loading
          if (favorites.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Display an error message if an error occurred during loading
          if (favorites.errorMessage != null) {
            return Center(child: Text(favorites.errorMessage!));
          }

          // Display the list of favorite items
          return ListView.builder(
            itemCount: favorites.items.length,
            itemBuilder: (context, index) {
              final item = favorites.items[index]; // Get each favorite item
              return Card(
                child: ListTile(
                  title: Text(item), // Display the item name
                  trailing: IconButton(
                    icon: const Icon(
                        Icons.delete), // Delete button to remove the item
                    onPressed: () {
                      favorites
                          .removeItem(item); // Remove the item from favorites
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
