class BreedingSheet {
  final String species;
  final String difficulty;
  final String humidity;
  final String temperature;
  final String hibernation;
  final String food;
  final String description;

  BreedingSheet({
    required this.species,
    required this.difficulty,
    required this.humidity,
    required this.temperature,
    required this.hibernation,
    required this.food,
    required this.description,
  });

  // toJson and fromJson might not be strictly needed for static content,
  // but good to have if we want to update them from a server later.
  Map<String, dynamic> toJson() {
    return {
      'species': species,
      'difficulty': difficulty,
      'humidity': humidity,
      'temperature': temperature,
      'hibernation': hibernation,
      'food': food,
      'description': description,
    };
  }

  factory BreedingSheet.fromJson(Map<String, dynamic> json) {
    return BreedingSheet(
      species: json['species'],
      difficulty: json['difficulty'],
      humidity: json['humidity'],
      temperature: json['temperature'],
      hibernation: json['hibernation'],
      food: json['food'],
      description: json['description'],
    );
  }
}
