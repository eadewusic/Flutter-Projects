class Country {
  final String name;
  final String capital;
  final String region;
  final int population;
  final String flag;
  final List<String> languages;

  Country({
    required this.name,
    required this.capital,
    required this.region,
    required this.population,
    required this.flag,
    required this.languages,
  });

  // Factory constructor to create a Country instance from JSON
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] ?? 'Unknown',
      capital: json['capital'] != null ? json['capital'][0] : 'No Capital',
      region: json['region'] ?? 'Unknown',
      population: json['population'] ?? 0,
      flag: json['flags']['png'] ?? '',
      languages: json['languages'] != null
          ? List<String>.from(json['languages'].values)
          : [],
    );
  }

  // Override equality for comparison
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
