import 'package:ant_manager/l10n/app_localizations.dart';
import 'package:ant_manager/models/stock_item.dart';
import 'package:ant_manager/providers/stock_provider.dart';
import 'package:ant_manager/screens/add_colony_screen.dart';
import 'package:ant_manager/screens/breeding_sheets_screen.dart';
import 'package:ant_manager/screens/colony_list_screen.dart';
import 'package:ant_manager/screens/export_screen.dart';
import 'package:ant_manager/screens/settings_screen.dart';
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

  String _getAppBarTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (_selectedIndex) {
      case 0:
        return l10n.colonies;
      case 1:
        return l10n.breedingSheets;
      case 2:
        return l10n.stock;
      default:
        return l10n.appTitle;
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
    final actions = <Widget>[];

    if (_selectedIndex == 0) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.qr_code),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ExportScreen()),
            );
          },
        ),
      );
    }

    actions.add(
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SettingsScreen()),
          );
        },
      ),
    );

    return actions;
  }

  void _showAddStockDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    final quantityController = TextEditingController();
    final unitController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.addStockItem),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: l10n.name),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: l10n.quantity),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: unitController,
              decoration: InputDecoration(labelText: l10n.unit),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
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
            child: Text(l10n.add),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(context)),
        actions: _appBarActions,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: _floatingActionButton,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: l10n.colonies,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book),
            label: l10n.breedingSheets,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.inventory),
            label: l10n.stock,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown,
        onTap: _onItemTapped,
      ),
    );
  }
}
