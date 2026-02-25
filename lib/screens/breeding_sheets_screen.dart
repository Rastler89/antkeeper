import 'package:ant_manager/models/breeding_sheet.dart';
import 'package:flutter/material.dart';

class BreedingSheetsScreen extends StatelessWidget {
  const BreedingSheetsScreen({super.key});

  static final List<BreedingSheet> _sheets = [
    BreedingSheet(
      species: 'Messor barbarus',
      difficulty: 'Easy',
      humidity: '50-70%',
      temperature: '22-28°C',
      hibernation: 'Yes (Nov-Mar at 10-15°C)',
      food: 'Seeds, insects',
      description: 'Granivorous species. Easy to keep. Needs a humidity gradient.',
    ),
    BreedingSheet(
      species: 'Lasius niger',
      difficulty: 'Easy',
      humidity: '50-60%',
      temperature: '20-25°C',
      hibernation: 'Yes (Oct-Mar at 5-10°C)',
      food: 'Sugar water, insects',
      description: 'Common garden ant. Very hardy and fast growing.',
    ),
    BreedingSheet(
      species: 'Camponotus cruentatus',
      difficulty: 'Medium',
      humidity: '40-60%',
      temperature: '24-30°C',
      hibernation: 'Yes (Nov-Feb at 10-15°C)',
      food: 'Sugar water, insects',
      description: 'Large species. Needs heat. Slow development initially.',
    ),
    // Add more...
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _sheets.length,
      itemBuilder: (context, index) {
        final sheet = _sheets[index];
        return Card(
          child: ExpansionTile(
            title: Text(sheet.species),
            subtitle: Text('Difficulty: ${sheet.difficulty}'),
            children: [
              ListTile(
                title: const Text('Temperature'),
                subtitle: Text(sheet.temperature),
              ),
              ListTile(
                title: const Text('Humidity'),
                subtitle: Text(sheet.humidity),
              ),
              ListTile(
                title: const Text('Hibernation'),
                subtitle: Text(sheet.hibernation),
              ),
              ListTile(
                title: const Text('Food'),
                subtitle: Text(sheet.food),
              ),
              ListTile(
                title: const Text('Description'),
                subtitle: Text(sheet.description),
              ),
            ],
          ),
        );
      },
    );
  }
}
