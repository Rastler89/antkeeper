import 'dart:io';
import 'package:ant_manager/providers/colony_provider.dart';
import 'package:ant_manager/screens/colony_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class ColonyListScreen extends StatelessWidget {
  const ColonyListScreen({super.key});

  Future<File?> _getImageFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    if (await file.exists()) {
      return file;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ColonyProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.colonies.isEmpty) {
          return const Center(child: Text('No colonies yet. Add one!'));
        }
        return ListView.builder(
          itemCount: provider.colonies.length,
          itemBuilder: (context, index) {
            final colony = provider.colonies[index];
            return Card(
              child: ListTile(
                leading: colony.images.isNotEmpty
                    ? FutureBuilder<File?>(
                        future: _getImageFile(colony.images.first),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done &&
                              snapshot.data != null) {
                            return Image.file(
                              snapshot.data!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.bug_report),
                            );
                          }
                          return const Icon(Icons.bug_report);
                        },
                      )
                    : const Icon(Icons.bug_report),
                title: Text(colony.name),
                subtitle: Text('${colony.species} - Pop: ${colony.population}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ColonyDetailScreen(colonyId: colony.id),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
