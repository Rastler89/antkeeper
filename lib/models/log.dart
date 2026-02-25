class Log {
  final DateTime date;
  final String content;

  Log({required this.date, required this.content});

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'content': content,
    };
  }

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      date: DateTime.parse(json['date']),
      content: json['content'],
    );
  }
}
