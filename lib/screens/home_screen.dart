import 'package:ant_manager/models/stock_item.dart';
import 'package:ant_manager/providers/stock_provider.dart';
import 'package:ant_manager/screens/add_colony_screen.dart';
import 'package:ant_manager/screens/breeding_sheets_screen.dart';
import 'package:ant_manager/screens/colony_list_screen.dart';
import 'package:ant_manager/screens/export_screen.dart';
import 'package:ant_manager/screens/stock_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ColonyListScreen(),
    BreedingSheetsScreen(),
    StockScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String get _appBarTitle {
    switch (_selectedIndex) {
      case 0:
        return 'Colonies';
      case 1:
        return 'Breeding Sheets';
      case 2:
        return 'Stock';
      default:
        return 'Ant Manager';
    }
  }

  Widget? get _floatingActionButton {
    if (_selectedIndex == 0) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddColonyScreen()),
          );
        },
        child: const Icon(Icons.add),
      );
    } else if (_selectedIndex == 2) {
      return FloatingActionButton(
        onPressed: () {
          _showAddStockDialog(context);
        },
        child: const Icon(Icons.add),
      );
    }
    return null;
  }

  List<Widget>? get _appBarActions {
    if (_selectedIndex == 0) {
      return [
        IconButton(
          icon: const Icon(Icons.qr_code),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ExportScreen()),
            );
          },
        ),
      ];
    }
    return null;
  }

  void _showAddStockDialog(BuildContext context) {
    final nameController = TextEditingController();
    final quantityController = TextEditingController();
    final unitController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Stock Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: unitController,
              decoration: const InputDecoration(labelText: 'Unit (e.g. g, ml)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text;
              final quantity = int.tryParse(quantityController.text) ?? 0;
              final unit = unitController.text;

              if (name.isNotEmpty && unit.isNotEmpty) {
                final newItem = StockItem(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: name,
                  quantity: quantity,
                  unit: unit,
                );
                Provider.of<StockProvider>(context, listen: false)
                    .addStockItem(newItem);
                Navigator.of(ctx).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: _appBarActions,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: _floatingActionButton,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Colonies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Breeding Sheets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Stock',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        onTap: _onItemTapped,
      ),
    );
  }
}
