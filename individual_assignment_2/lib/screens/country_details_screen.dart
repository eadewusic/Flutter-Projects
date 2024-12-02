import 'package:flutter/material.dart';
import '../models/country_model.dart';

// A screen to display detailed information about a selected country.
class CountryDetailsScreen extends StatelessWidget {
  /// The [Country] object containing the details to display.
  final Country country;

  // Constructor that requires a [Country] object and accepts an optional key.
  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xE0E3F8FF), // Light blue background color with transparency
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // AppBar with a blue accent color
        title: Text(
          country.name, // Display the country name as the AppBar title
          style: const TextStyle(
            color: Colors.white, // Title text color set to white
            fontWeight: FontWeight.bold, // Title text is bold
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Back button icon color set to white
          ),
          onPressed: () {
            Navigator.pop(context); // Return to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        // Allows the content to be scrollable if it overflows
        child: Padding(
          padding:
              const EdgeInsets.all(16.0), // Adds padding around the content
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Aligns content to the center
            children: [
              Image.network(
                country.flag, // Displays the country's flag from a URL
                width:
                    double.infinity, // Makes the image take up the full width
                height: 200, // Sets a fixed height for the image
                fit: BoxFit.cover, // Scales the image to cover its box
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.flag, // Displays a flag icon as a fallback
                    size: 200, // Sets the icon size
                  );
                },
              ),
              const SizedBox(
                  height: 20), // Adds space between the image and the details
              _buildDetailCard([
                // Build a card widget with country details
                'Capital: ${country.capital}', // Displays the capital
                'Population: ${country.population}', // Displays the population
                'Region: ${country.region}', // Displays the region
                'Languages: ${country.languages.join(', ')}', // Displays languages
              ]),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a styled card widget displaying a list of country details.
  Widget _buildDetailCard(List<String> details) {
    return Card(
      elevation: 4, // Adds shadow for a lifted effect
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Adds padding inside the card
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns text to the left
          children: details.map((detail) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 4.0), // Adds spacing between rows
              child: Text(
                detail, // Displays each detail as text
                style: const TextStyle(
                    fontSize: 16), // Sets a consistent font size
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
