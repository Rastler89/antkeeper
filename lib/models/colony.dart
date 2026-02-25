import 'package:ant_manager/models/log.dart';
import 'package:ant_manager/models/population_entry.dart';

class Colony {
  final String id;
  String name;
  String species;
  int population;
  String description;
  final DateTime acquisitionDate;
  List<String> images;
  List<PopulationEntry> populationHistory;
  List<Log> logs;

  Colony({
    required this.id,
    required this.name,
    required this.species,
    required this.population,
    required this.description,
    required this.acquisitionDate,
    List<String>? images,
    List<PopulationEntry>? populationHistory,
    List<Log>? logs,
  })  : images = images ?? [],
        populationHistory = populationHistory ?? [],
        logs = logs ?? [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'species': species,
      'population': population,
      'description': description,
      'acquisitionDate': acquisitionDate.toIso8601String(),
      'images': images,
      'populationHistory': populationHistory.map((e) => e.toJson()).toList(),
      'logs': logs.map((e) => e.toJson()).toList(),
    };
  }

  factory Colony.fromJson(Map<String, dynamic> json) {
    return Colony(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      population: json['population'],
      description: json['description'],
      acquisitionDate: DateTime.parse(json['acquisitionDate']),
      images: List<String>.from(json['images'] ?? []),
      populationHistory: (json['populationHistory'] as List<dynamic>?)
              ?.map((e) => PopulationEntry.fromJson(e))
              .toList() ??
          [],
      logs: (json['logs'] as List<dynamic>?)
              ?.map((e) => Log.fromJson(e))
              .toList() ??
          [],
    );
  }
}
