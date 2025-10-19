import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final ValueChanged<Priority> onPriorityChanged;

  const TaskTile({
    Key? key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onPriorityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: Checkbox(
          value: task.done,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          task.name,
          style: TextStyle(
            decoration: task.done ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        subtitle: Row(
          children: [
            const Text('Priority: '),
            DropdownButton<Priority>(
              value: task.priority,
              underline: const SizedBox(),
              items: Priority.values.map((p) {
                return DropdownMenuItem(
                  value: p,
                  child: Text(
                    p.toString().split('.').last,
                    style: TextStyle(
                      color: _priorityColor(p),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (p) {
                if (p != null) onPriorityChanged(p);
              },
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
          tooltip: 'Delete Task',
        ),
      ),
    );
  }

  Color _priorityColor(Priority p) {
    switch (p) {
      case Priority.high:
        return const Color.fromARGB(255, 249, 66, 53);
      case Priority.medium:
        return const Color.fromARGB(255, 240, 144, 1);
      case Priority.low:
        return const Color.fromARGB(255, 75, 180, 78);
    }
  }
}
