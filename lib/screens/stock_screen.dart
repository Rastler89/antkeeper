import 'package:ant_manager/providers/stock_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StockProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.stock.isEmpty) {
          return const Center(child: Text('No stock items. Add one!'));
        }
        return ListView.builder(
          itemCount: provider.stock.length,
          itemBuilder: (context, index) {
            final item = provider.stock[index];
            return Card(
              child: ListTile(
                title: Text(item.name),
                subtitle: Text('Quantity: ${item.quantity} ${item.unit}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (item.quantity > 0) {
                          provider.updateStockItem(item.id, item.quantity - 1);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        provider.updateStockItem(item.id, item.quantity + 1);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        provider.deleteStockItem(item.id);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
