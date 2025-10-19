
enum Priority { low, medium, high }


class Task {
  
  String id;

  String name;

  bool done;

  
  Priority priority;

  Task({
    required this.id,
    required this.name,
    this.done = false,
    this.priority = Priority.medium,
  });

  
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      name: json['name'] as String,
      done: json['done'] as bool,
      priority: Priority.values[json['priority'] as int],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'done': done,
      'priority': priority.index,
    };
  }
}
