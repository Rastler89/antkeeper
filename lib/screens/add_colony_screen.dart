import 'dart:io';
import 'package:ant_manager/models/colony.dart';
import 'package:ant_manager/providers/colony_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddColonyScreen extends StatefulWidget {
  const AddColonyScreen({super.key});

  @override
  State<AddColonyScreen> createState() => _AddColonyScreenState();
}

class _AddColonyScreenState extends State<AddColonyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _speciesController = TextEditingController();
  final _populationController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _nameController.dispose();
    _speciesController.dispose();
    _populationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _saveColony() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final species = _speciesController.text;
      final population = int.tryParse(_populationController.text) ?? 0;
      final description = _descriptionController.text;
      final id = DateTime.now().millisecondsSinceEpoch.toString();

      final newColony = Colony(
        id: id,
        name: name,
        species: species,
        population: population,
        description: description,
        acquisitionDate: DateTime.now(),
        images: _selectedImage != null ? [_selectedImage!.path] : [],
      );

      Provider.of<ColonyProvider>(context, listen: false).addColony(newColony);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Colony'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _selectedImage != null
                      ? Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                            Text('Tap to add photo'),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _speciesController,
                decoration: const InputDecoration(labelText: 'Species'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a species';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _populationController,
                decoration: const InputDecoration(labelText: 'Initial Population'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a population';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveColony,
                child: const Text('Save Colony'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
