import 'dart:convert'; // Provides tools for encoding and decoding JSON data
import 'package:http/http.dart' as http; // Enables HTTP requests for REST API interaction
import '../models/country_model.dart';

class ApiService {
  // Base URL for the REST Countries API.
  static const String baseUrl = 'https://restcountries.com/v3.1';

  // Searches for countries by name using the REST Countries API.
  //
  // This function sends an HTTP GET request to the API endpoint with the
  // specified query. If the request is successful, it decodes the JSON response
  // and maps it to a list of `Country` objects. In case of failure, an exception
  // is thrown with an appropriate error message.
  //
  // Parameters:
  // - [query]: The name or partial name of the country to search for.
  //
  // Returns:
  // - A `Future` that resolves to a list of `Country` objects.
  //
  // Throws:
  // - `Exception`: If the API request fails or the response cannot be processed.
  static Future<List<Country>> searchCountries(String query) async {
    try {
      // Build the complete URL for the API request using the query parameter.
      final response = await http.get(Uri.parse('$baseUrl/name/$query'));

      // Check if the request was successful (HTTP 200 OK).
      if (response.statusCode == 200) {
        // Decode the JSON response body into a dynamic list.
        final List<dynamic> data = json.decode(response.body);

        // Map each JSON object to a Country model and return the resulting list.
        return data.map((json) => Country.fromJson(json)).toList();
      } else {
        // Throw an exception for non-200 HTTP status codes.
        throw Exception('Failed to load countries');
      }
    } catch (e) {
      // Catch and rethrow any errors that occur during the request or processing.
      throw Exception('Error: $e');
    }
  }
}
