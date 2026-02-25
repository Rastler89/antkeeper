import 'dart:io';
import 'package:ant_manager/models/colony.dart';
import 'package:ant_manager/providers/colony_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ColonyDetailScreen extends StatelessWidget {
  final String colonyId;

  const ColonyDetailScreen({super.key, required this.colonyId});

  Future<File?> _getImageFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    if (await file.exists()) {
      return file;
    }
    // Fallback for legacy paths (full paths) if any
    final legacyFile = File(filename);
    if (await legacyFile.exists()) {
      return legacyFile;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colonyProvider = Provider.of<ColonyProvider>(context);
    final colony = colonyProvider.colonies.firstWhere(
      (c) => c.id == colonyId,
      orElse: () => Colony(
        id: '',
        name: 'Not Found',
        species: '',
        population: 0,
        description: '',
        acquisitionDate: DateTime.now(),
      ),
    );

    if (colony.id.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Colony not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(colony.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Delete Colony'),
                  content: const Text(
                      'Are you sure you want to delete this colony?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        colonyProvider.deleteColony(colony.id);
                        Navigator.of(ctx).pop(); // Close dialog
                        Navigator.of(context).pop(); // Go back to list
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (colony.images.isNotEmpty)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: colony.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FutureBuilder<File?>(
                        future: _getImageFile(colony.images[index]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.data != null) {
                            return Image.file(
                              snapshot.data!,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                      width: 200,
                                      color: Colors.grey,
                                      child: const Icon(Icons.broken_image)),
                            );
                          }
                          return Container(
                              width: 200,
                              color: Colors.grey[300],
                              child: const Center(
                                  child: CircularProgressIndicator()));
                        },
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            Text(
              'Species: ${colony.species}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Acquired: ${DateFormat.yMMMd().format(colony.acquisitionDate)}'),
            const SizedBox(height: 8),
            Text('Population: ${colony.population}'),
            const SizedBox(height: 16),
            Text('Description:', style: Theme.of(context).textTheme.titleMedium),
            Text(colony.description),
            const SizedBox(height: 24),
            Text('Population History:',
                style: Theme.of(context).textTheme.titleMedium),
            SizedBox(
              height: 200,
              child: colony.populationHistory.isEmpty
                  ? const Center(child: Text('No history yet'))
                  : LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: colony.populationHistory
                                .asMap()
                                .entries
                                .map((e) => FlSpot(
                                    e.key.toDouble(), e.value.count.toDouble()))
                                .toList(),
                            isCurved: true,
                            color: Colors.blue,
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Logs:', style: Theme.of(context).textTheme.titleMedium),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    _showAddLogDialog(context, colonyProvider, colony.id);
                  },
                ),
              ],
            ),
            ...colony.logs.map((log) => Card(
                  child: ListTile(
                    title: Text(log.content),
                    subtitle: Text(DateFormat.yMMMd().add_jm().format(log.date)),
                  ),
                )),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                _showUpdatePopulationDialog(
                    context, colonyProvider, colony.id, colony.population);
              },
              child: const Text('Update Population'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddLogDialog(
      BuildContext context, ColonyProvider provider, String colonyId) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Log Entry'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Log content'),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                provider.addLog(colonyId, controller.text);
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showUpdatePopulationDialog(BuildContext context,
      ColonyProvider provider, String colonyId, int currentPopulation) {
    final controller = TextEditingController(text: currentPopulation.toString());
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update Population'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'New Population'),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final newPop = int.tryParse(controller.text);
              if (newPop != null) {
                provider.updatePopulation(colonyId, newPop);
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}
