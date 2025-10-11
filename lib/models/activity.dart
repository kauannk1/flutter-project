class Activity {
  final String id;
  final String title;
  final String description;
  final DateTime due;
  final String status;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.due,
    this.status = 'pending',
  });

  factory Activity.fromMap(String id, Map<String, dynamic> m) => Activity(
        id: id,
        title: m['title'] ?? '',
        description: m['description'] ?? '',
        due: (m['dueDate'] != null)
            ? DateTime.tryParse('${m['dueDate']} ${m['dueTime'] ?? '00:00'}') ??
                DateTime.now()
            : (m['due'] as DateTime? ?? DateTime.now()),
        status: m['status'] ?? 'pending',
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'dueDate':
            '${due.year.toString().padLeft(4, '0')}-${due.month.toString().padLeft(2, '0')}-${due.day.toString().padLeft(2, '0')}',
        'dueTime':
            '${due.hour.toString().padLeft(2, '0')}:${due.minute.toString().padLeft(2, '0')}',
        'status': status,
      };
}
