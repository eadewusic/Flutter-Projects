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
    // Ensures countries are fetched when the screen is first loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CountryProvider>(context, listen: false).fetchCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access providers for managing countries and comparisons
    final countryProvider = Provider.of<CountryProvider>(context);
    final compareProvider = Provider.of<CompareProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ExploreX: A Country Explorer App 🌍', // App's main title
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent, // AppBar background color
        elevation: 0, // Remove AppBar shadow
      ),
      body: Container(
        color: const Color(0xE0E3F8FF), // Background color for the screen
        child: Column(
          children: [
            // Search bar for filtering countries
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search countries...', // Placeholder text
                  prefixIcon: const Icon(Icons.search,
                      color: Colors.blueAccent), // Search icon
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear,
                        color: Colors.redAccent), // Clear icon
                    onPressed: () {
                      _searchController.clear(); // Clear search input
                      countryProvider
                          .filterCountries(''); // Reset country filter
                    },
                  ),
                  filled: true, // Background fill for TextField
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    borderSide: const BorderSide(
                        color: Colors.blueAccent), // Border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color:
                            Colors.deepOrangeAccent), // Border color on focus
                  ),
                ),
                onChanged: (value) {
                  countryProvider
                      .filterCountries(value); // Update country list on search
                },
              ),
            ),
            // Display error message if fetching countries fails
            if (countryProvider.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  countryProvider.errorMessage,
                  style: const TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ),
            // Display error message if comparison list fails
            if (compareProvider.errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  compareProvider.errorMessage,
                  style: const TextStyle(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ),
            // Display list of countries or relevant messages
            Expanded(
              child: countryProvider.isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Show loading spinner
                  : countryProvider.countries.isEmpty
                      ? const Center(
                          child: Text(
                            'No countries found.', // Message for empty search results
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          itemCount: countryProvider
                              .countries.length, // Number of countries
                          itemBuilder: (context, index) {
                            final country = countryProvider.countries[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 8.0), // Card margin
                              color: Colors.white,
                              shadowColor: Colors.grey[400], // Shadow color
                              elevation: 4, // Card elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Rounded card corners
                              ),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      8), // Rounded image corners
                                  child: Image.network(
                                    country.flag, // Country flag image
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(Icons.flag,
                                          color: Colors
                                              .grey); // Fallback icon for missing flag
                                    },
                                  ),
                                ),
                                title: Text(
                                  country.name, // Country name
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                subtitle: Text(
                                  country.capital, // Country capital
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    compareProvider.isInCompareList(country)
                                        ? Icons.check_box // Selected country
                                        : Icons
                                            .check_box_outline_blank, // Unselected country
                                    color:
                                        compareProvider.isInCompareList(country)
                                            ? Colors.blueAccent
                                            : Colors.grey,
                                  ),
                                  onPressed: () {
                                    compareProvider.toggleCompare(
                                        country); // Toggle comparison
                                  },
                                ),
                                onTap: () {
                                  // Navigate to details screen
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
      // Floating action button - FAB for comparing selected countries
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (compareProvider.compareList.length < 2) {
            // Show a warning if fewer than 2 countries are selected
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please select at least 2 countries to compare.'),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else {
            // Navigate to compare screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CompareScreen()),
            );
          }
        },
        tooltip: 'Compare Selected Countries', // Tooltip for FAB
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.compare),
        label: const Text('Compare'),
      ),
    );
  }
}
