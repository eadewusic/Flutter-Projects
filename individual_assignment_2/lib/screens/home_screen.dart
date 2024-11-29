import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/country_provider.dart';
import '../providers/compare_provider.dart';
import '../screens/country_details_screen.dart';
import '../screens/compare_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch countries when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CountryProvider>(context, listen: false).fetchCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);
    final compareProvider = Provider.of<CompareProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ExploreX: A Country Explorer App 🌍',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Container(
        color: const Color(0xE0E3F8FF), // Updated background color
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search countries...',
                  prefixIcon:
                      const Icon(Icons.search, color: Colors.blueAccent),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.redAccent),
                    onPressed: () {
                      _searchController.clear();
                      countryProvider.filterCountries('');
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Colors.deepOrangeAccent),
                  ),
                ),
                onChanged: (value) {
                  countryProvider.filterCountries(value);
                },
              ),
            ),
            if (countryProvider.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  countryProvider.errorMessage,
                  style: const TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ),
            if (compareProvider.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  compareProvider.errorMessage,
                  style: const TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ),
            Expanded(
              child: countryProvider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : countryProvider.countries.isEmpty
                      ? const Center(
                          child: Text(
                            'No countries found.',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: countryProvider.countries.length,
                          itemBuilder: (context, index) {
                            final country = countryProvider.countries[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              color: Colors.white,
                              shadowColor: Colors.grey[400],
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    country.flag,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.flag,
                                          color: Colors.grey);
                                    },
                                  ),
                                ),
                                title: Text(
                                  country.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                subtitle: Text(
                                  country.capital,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    compareProvider.isInCompareList(country)
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color:
                                        compareProvider.isInCompareList(country)
                                            ? Colors.blueAccent
                                            : Colors.grey,
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
                                          CountryDetailsScreen(
                                              country: country),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (compareProvider.compareList.length < 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select at least 2 countries to compare.'),
                backgroundColor: Colors.redAccent,
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
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.compare),
        label: const Text('Compare'),
      ),
    );
  }
}
