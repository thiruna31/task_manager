import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class PersistenceService {
  static const _kKey = 'tasks_v1';

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = tasks.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(_kKey, jsonList);
  }

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_kKey) ?? [];
    return list.map((s) => Task.fromJson(jsonDecode(s))).toList();
  }
}
