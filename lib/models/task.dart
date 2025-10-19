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

  factory Task.fromJson(Map<String,dynamic> j) => Task(
    id: j['id'],
    name: j['name'],
    done: j['done'],
    priority: Priority.values[j['priority']],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'done': done,
    'priority': priority.index,
  };
}
