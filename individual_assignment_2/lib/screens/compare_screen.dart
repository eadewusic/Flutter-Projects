import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/compare_provider.dart';

// A screen that allows users to compare selected countries
// and view their details side by side.
class CompareScreen extends StatelessWidget {
  const CompareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the CompareProvider instance to get the comparison data.
    final compareProvider = Provider.of<CompareProvider>(context);
    final countries = compareProvider.compareList;

    return Scaffold(
      backgroundColor:
          const Color(0xE0E3F8FF), // Light blue background for the screen.
      appBar: AppBar(
        backgroundColor: Colors.blueAccent, // AppBar with a blue accent theme.
        title: const Text(
          'Compare Countries',
          style: TextStyle(
            color: Colors.white, // White text for better visibility.
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          // Navigate back to the previous screen.
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            // Clear the comparison list and navigate back to the previous screen.
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              compareProvider.clearCompareList();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: countries.length < 2
                ? Center(
                    // Display a message if fewer than two countries are selected.
                    child: Text(
                      countries.isEmpty
                          ? 'No countries selected for comparison.'
                          : 'Select one more country for comparison.',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    // Display the details of two selected countries.
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      final country = countries[index];
                      return Card(
                        margin: const EdgeInsets.all(
                            8.0), // Card margins for spacing.
                        child: Padding(
                          padding: const EdgeInsets.all(
                              16.0), // Padding inside each card.
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                country.name, // Country name in bold.
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                  height: 10), // Spacing between elements.
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    // Display key details about the country.
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
                                  // Display the country's flag as an image.
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
          // Button to view comparison history in a bottom sheet.
          ElevatedButton(
            onPressed: () {
              // Add the current comparison to the history and display it.
              compareProvider.addComparisonToHistory();
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20), // Rounded corners for the sheet.
                  ),
                ),
                builder: (BuildContext context) {
                  final historyList = compareProvider.historyList;
                  return Container(
                    padding: const EdgeInsets.all(
                        16), // Padding inside the bottom sheet.
                    height: MediaQuery.of(context).size.height *
                        0.4, // Sheet height.
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          // Title for the history section.
                          child: Text(
                            'Comparison History',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(), // Divider for visual separation.
                        Expanded(
                          child: historyList.isEmpty
                              ? const Center(
                                  // Message if no history is available.
                                  child: Text(
                                    'No comparison history available.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              : ListView.builder(
                                  // List of past comparisons.
                                  itemCount: historyList.length,
                                  itemBuilder: (context, index) {
                                    final comparison = historyList[index];
                                    return ListTile(
                                      title: Text(
                                        '${comparison[0].name} vs ${comparison[1].name}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                        Align(
                          // Close button to dismiss the sheet.
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.blueAccent, // Blue accent color for the button.
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Rounded corners.
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 148, vertical: 15),
            ),
            child: const Text(
              'View History', // Button text.
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
