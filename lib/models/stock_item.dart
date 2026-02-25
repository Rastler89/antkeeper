class StockItem {
  final String id;
  String name;
  int quantity;
  String unit; // e.g., 'g', 'ml', 'pcs'

  StockItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }

  factory StockItem.fromJson(Map<String, dynamic> json) {
    return StockItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }
}
