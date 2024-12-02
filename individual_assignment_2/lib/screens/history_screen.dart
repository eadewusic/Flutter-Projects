import 'package:flutter/material.dart';
import 'package:individual_assignment_2/providers/compare_provider.dart';
import 'package:provider/provider.dart';

// This screen displays the comparison history stored in the CompareProvider
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the CompareProvider to get the historyList and other functionalities
    final provider = Provider.of<CompareProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparison History'), // AppBar title
      ),
      body: provider.historyList.isEmpty
          // Display a message if the historyList is empty
          ? const Center(
              child: Text(
                'No history available.',
                style: TextStyle(fontSize: 18), // Style for the message text
              ),
            )
          : ListView.builder(
              // Dynamically creating a list of comparison items
              itemCount: provider.historyList.length,
              itemBuilder: (context, index) {
                final comparison =
                    provider.historyList[index]; // Retrieve each comparison
                return ListTile(
                  // Displaying the names of the items being compared
                  title: Text('${comparison[0].name} vs ${comparison[1].name}'),
                  // Displaying the regions of the compared items
                  subtitle: Text(
                    'Regions: ${comparison[0].region} vs ${comparison[1].region}',
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        // Opens the bottom sheet to show the comparison history in more detail
        onPressed: () => _showBottomSheet(context, provider),
        child:
            const Icon(Icons.history), // Icon for the floating action button
      ),
    );
  }

  // Displays a bottom sheet with a detailed view of the comparison history
  void _showBottomSheet(BuildContext context, CompareProvider provider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        // Adds rounded corners to the top of the bottom sheet
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16), // Adds padding around the content
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Minimizes the vertical space used
            children: [
              const Text(
                'Comparison History', // Title for the bottom sheet.
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              provider.historyList.isEmpty
                  // Show a message if no comparisons are available
                  ? const Center(
                      child: Text(
                        'No comparisons yet.',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap:
                          true, // Ensure the list fits within the bottom sheet
                      itemCount: provider.historyList.length,
                      itemBuilder: (context, index) {
                        final comparison = provider.historyList[index];
                        return ListTile(
                          // Displaying the names of the items being compared
                          title: Text(
                              '${comparison[0].name} vs ${comparison[1].name}'),
                          // Displaying the regions of the compared items
                          subtitle: Text(
                            'Regions: ${comparison[0].region} vs ${comparison[1].region}',
                          ),
                        );
                      },
                    ),
              TextButton(
                // Closes the bottom sheet
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
