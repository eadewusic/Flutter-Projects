import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import '../providers/compare_provider.dart';
import '../screens/country_details_screen.dart';
import '../screens/compare_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);
    final compareProvider = Provider.of<CompareProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ExploreX - Countries'),
      ),
      body: countryProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : countryProvider.countries.isEmpty
              ? const Center(
                  child: Text(
                    'No countries available.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: countryProvider.countries.length,
                  itemBuilder: (context, index) {
                    final country = countryProvider.countries[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: ListTile(
                        leading: Image.network(
                          country.flag,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(country.name),
                        subtitle: Text(country.capital),
                        trailing: IconButton(
                          icon: Icon(
                            compareProvider.isInCompareList(country)
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                          ),
                          onPressed: () {
                            compareProvider.toggleCompare(country);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CountryDetailsScreen(country: country),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (compareProvider.compareList.length < 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Please select at least 2 countries to compare.'),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CompareScreen()),
            );
          }
        },
        tooltip: 'Compare Selected Countries',
        child: const Icon(Icons.compare),
      ),
    );
  }
}
