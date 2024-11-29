import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/compare_provider.dart';

class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final compareProvider = Provider.of<CompareProvider>(context);
    final countries = compareProvider.compareList;

    return Scaffold(
      backgroundColor: const Color(0xE0E3F8FF), // Set background color
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // Blue accent color for the AppBar
        title: const Text(
          'Compare Countries',
          style: TextStyle(
            color: Colors.white, // White color for the title text
            fontWeight: FontWeight.bold, // Bold title text
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white, // White color for back icon
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Colors.white, // White color for the refresh icon
            ),
            onPressed: () {
              compareProvider.resetComparison();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: countries.length < 2
          ? Center(
              child: Text(
                countries.isEmpty
                    ? 'No countries selected for comparison.'
                    : 'Select one more country for comparison.',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      final country = countries[index];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                country.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Capital: ${country.capital}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          'Population: ${country.population}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          'Region: ${country.region}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        Text(
                                          'Languages: ${country.languages.join(', ')}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Image.network(
                                    country.flag,
                                    width: 100,
                                    height: 70,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
