import 'package:flutter/material.dart';
import '../models/country_model.dart';

class CountryDetailsScreen extends StatelessWidget {
  final Country country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(country.flag, width: double.infinity, height: 200),
            const SizedBox(height: 10),
            Text('Capital: ${country.capital}',
                style: const TextStyle(fontSize: 18)),
            Text('Population: ${country.population}',
                style: const TextStyle(fontSize: 18)),
            Text('Region: ${country.region}',
                style: const TextStyle(fontSize: 18)),
            Text('Languages: ${country.languages.join(', ')}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
