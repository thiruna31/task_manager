import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import '../services/persistence_service.dart';

class TaskListScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const TaskListScreen({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TextEditingController _controller = TextEditingController();
  final PersistenceService _persistence = PersistenceService();
  List<Task> _tasks = [];
  Priority _selectedPriority = Priority.medium;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final loaded = await _persistence.loadTasks();
    setState(() {
      _tasks = loaded;
      _sortTasks();
    });
  }

  Future<void> _saveTasks() async {
    await _persistence.saveTasks(_tasks);
  }

  void _addTask(String name) {
    if (name.trim().isEmpty) return;
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      priority: _selectedPriority,
    );
    setState(() {
      _tasks.add(newTask);
      _sortTasks();
    });
    _controller.clear();
    _saveTasks();
  }

  void _toggleTask(String id) {
    setState(() {
      final t = _tasks.firstWhere((task) => task.id == id);
      t.done = !t.done;
    });
    _saveTasks();
  }

  void _deleteTask(String id) {
    setState(() {
      _tasks.removeWhere((task) => task.id == id);
    });
    _saveTasks();
  }

  void _changePriority(String id, Priority newPriority) {
    setState(() {
      final t = _tasks.firstWhere((task) => task.id == id);
      t.priority = newPriority;
      _sortTasks();
    });
    _saveTasks();
  }

  void _sortTasks() {
   
    _tasks.sort((a, b) => b.priority.index.compareTo(a.priority.index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: widget.onToggleTheme,
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: Column(
        children: [
          // 🔸 Add Task Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter a new task',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<Priority>(
                  value: _selectedPriority,
                  items: Priority.values.map((p) {
                    return DropdownMenuItem(
                      value: p,
                      child: Text(p.toString().split('.').last),
                    );
                  }).toList(),
                  onChanged: (p) {
                    if (p != null) {
                      setState(() {
                        _selectedPriority = p;
                      });
                    }
                  },
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _addTask(_controller.text),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

        
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child: Text(
                      'No tasks yet.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final t = _tasks[index];
                      return TaskTile(
                        task: t,
                        onToggle: () => _toggleTask(t.id),
                        onDelete: () => _deleteTask(t.id),
                        onPriorityChanged: (newP) => _changePriority(t.id, newP),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
