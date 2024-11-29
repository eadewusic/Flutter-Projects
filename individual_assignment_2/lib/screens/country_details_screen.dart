import 'package:flutter/material.dart';
import '../models/country_model.dart';

class CountryDetailsScreen extends StatelessWidget {
  final Country country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xE0E3F8FF), // Very light shade of blue (RGBA with 80% opacity)
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Set the AppBar background color
        title: Text(
          country.name,
          style: const TextStyle(
            color: Colors.white, // Set text color to white
            fontWeight: FontWeight.bold, // Set text to bold
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // Set back icon color to white
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                country.flag,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.flag,
                    size: 200,
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildDetailCard([
                'Capital: ${country.capital}',
                'Population: ${country.population}',
                'Region: ${country.region}',
                'Languages: ${country.languages.join(', ')}',
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard(List<String> details) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: details.map((detail) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                detail,
                style: const TextStyle(fontSize: 16),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
