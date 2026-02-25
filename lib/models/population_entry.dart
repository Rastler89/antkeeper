class PopulationEntry {
  final DateTime date;
  final int count;

  PopulationEntry({required this.date, required this.count});

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'count': count,
    };
  }

  factory PopulationEntry.fromJson(Map<String, dynamic> json) {
    return PopulationEntry(
      date: DateTime.parse(json['date']),
      count: json['count'],
    );
  }
}
