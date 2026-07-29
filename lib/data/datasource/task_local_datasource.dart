import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';

/// TaskLocalDataSource - reads/writes the full task list as a single JSON
/// blob in SharedPreferences.
///
/// This stands in for FirebaseTaskRepository/firebaseConfig.js on the web
/// app for now. Swapping this out for a FirebaseTaskDataSource later only
/// touches this file and the repository implementation below it — nothing
/// in domain/ or app/ has to change, same as swapping repositories on web
/// via REACT_APP_TASK_REPOSITORY.
abstract class TaskLocalDataSource {
  Future<List<TaskEntity>> getAllTasks();
  Future<void> saveAllTasks(List<TaskEntity> tasks);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  static const _storageKey = 'taskflow_tasks';

  @override
  Future<List<TaskEntity>> getAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return [];

    final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((e) => TaskEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveAllTasks(List<TaskEntity> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(tasks.map((t) => t.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }
}
