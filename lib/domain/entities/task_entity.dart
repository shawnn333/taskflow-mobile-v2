/// TaskEntity - mirrors domain/entities/Task.js from the web app.
///
/// Same rules: id + non-empty title required, completed defaults to false,
/// createdAt/updatedAt are timestamps. Kept immutable (Dart-idiomatic);
/// mutations return a new instance via copyWith instead of mutating in place.
class TaskEntity {
  final String id;
  final String title;
  final bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;

  TaskEntity({
    required this.id,
    required String title,
    this.completed = false,
    required this.createdAt,
    required this.updatedAt,
  }) : title = title.trim() {
    if (id.isEmpty) {
      throw ArgumentError('Task id is required');
    }
    if (this.title.isEmpty) {
      throw ArgumentError('Task title cannot be empty');
    }
  }

  /// Equivalent of Task.create(title, createdAt) in Task.js.
  factory TaskEntity.create({required String title, DateTime? createdAt}) {
    final now = DateTime.now();
    final id =
        '${now.microsecondsSinceEpoch}-${(now.hashCode ^ title.hashCode).toRadixString(36)}';
    return TaskEntity(
      id: id,
      title: title,
      completed: false,
      createdAt: createdAt ?? now,
      updatedAt: now,
    );
  }

  bool get isPending => !completed;

  TaskEntity updateTitle(String newTitle) {
    if (newTitle.trim().isEmpty) {
      throw ArgumentError('Task title cannot be empty');
    }
    return copyWith(title: newTitle.trim(), updatedAt: DateTime.now());
  }

  TaskEntity toggleComplete() {
    return copyWith(completed: !completed, updatedAt: DateTime.now());
  }

  TaskEntity copyWith({
    String? title,
    bool? completed,
    DateTime? updatedAt,
  }) {
    return TaskEntity(
      id: id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'completed': completed,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };

  factory TaskEntity.fromJson(Map<String, dynamic> json) {
    return TaskEntity(
      id: json['id'].toString(),
      title: (json['title'] ?? '').toString(),
      completed: json['completed'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }
}
