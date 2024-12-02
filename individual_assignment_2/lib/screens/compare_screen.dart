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
      backgroundColor: const Color(0xE0E3F8FF),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Compare Countries',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
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
                    child: Text(
                      countries.isEmpty
                          ? 'No countries selected for comparison.'
                          : 'Select one more country for comparison.',
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
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
          ElevatedButton(
            onPressed: () {
              compareProvider.addComparisonToHistory();
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (BuildContext context) {
                  final historyList = compareProvider.historyList;
                  return Container(
                    padding: const EdgeInsets.all(16),
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'Comparison History',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: historyList.isEmpty
                              ? const Center(
                                  child: Text(
                                    'No comparison history available.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              : ListView.builder(
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
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 148, vertical: 15),
            ),
            child: const Text(
              'View History',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
