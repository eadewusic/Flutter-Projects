import 'package:flutter/material.dart';
import 'package:individual_assignment_2/providers/compare_provider.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CompareProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparison History'),
      ),
      body: provider.historyList.isEmpty // Updated to historyList
          ? const Center(
              child: Text(
                'No history available.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: provider.historyList.length, // Updated to historyList
              itemBuilder: (context, index) {
                final comparison =
                    provider.historyList[index]; // Updated to historyList
                return ListTile(
                  title: Text('${comparison[0].name} vs ${comparison[1].name}'),
                  subtitle: Text(
                    'Regions: ${comparison[0].region} vs ${comparison[1].region}',
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottomSheet(context, provider),
        child: const Icon(Icons.history),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, CompareProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Comparison History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              provider.historyList.isEmpty // Updated to historyList
                  ? const Center(
                      child: Text(
                        'No comparisons yet.',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          provider.historyList.length, // Updated to historyList
                      itemBuilder: (context, index) {
                        final comparison = provider
                            .historyList[index]; // Updated to historyList
                        return ListTile(
                          title: Text(
                              '${comparison[0].name} vs ${comparison[1].name}'),
                          subtitle: Text(
                            'Regions: ${comparison[0].region} vs ${comparison[1].region}',
                          ),
                        );
                      },
                    ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
