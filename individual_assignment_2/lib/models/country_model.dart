class Country {
  final String name;
  final String flag;
  final String capital;
  final int population;
  final String region;
  final List<String> languages;

  Country({
    required this.name,
    required this.flag,
    required this.capital,
    required this.population,
    required this.region,
    required this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      flag: json['flags']['png'],
      capital: json['capital']?.first ?? 'N/A',
      population: json['population'],
      region: json['region'],
      languages: (json['languages'] as Map<String, dynamic>?)
              ?.values
              .map((lang) => lang as String)
              .toList() ??
          [],
    );
  }
}
