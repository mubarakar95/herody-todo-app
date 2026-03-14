import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/app_constants.dart';
import '../models/task_model.dart';

class DatabaseService {
  final String? _idToken;
  final String? _localId;

  DatabaseService(this._idToken, this._localId);

  String? get userId => _localId;

  Future<List<Task>> getTasks() async {
    if (_localId == null || _idToken == null) {
      throw Exception('User not authenticated');
    }

    try {
      final url = Uri.parse(
        '${AppConstants.firebaseDatabaseBaseUrl}/users/$_localId/${AppConstants.tasksNode}.json?auth=$_idToken',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data == null) {
          return [];
        }

        final List<Task> tasks = [];
        data.forEach((key, value) {
          tasks.add(Task.fromJson(value));
        });

        tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return tasks;
      } else {
        throw Exception('Failed to load tasks: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching tasks: $e');
    }
  }

  Future<Task> addTask(Task task) async {
    if (_localId == null || _idToken == null) {
      throw Exception('User not authenticated');
    }

    try {
      final url = Uri.parse(
        '${AppConstants.firebaseDatabaseBaseUrl}/users/$_localId/${AppConstants.tasksNode}.json?auth=$_idToken',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(task.toJson()),
      );

      if (response.statusCode == 200) {
        return task;
      } else {
        throw Exception('Failed to add task: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding task: $e');
    }
  }

  Future<Task> updateTask(Task task) async {
    if (_localId == null || _idToken == null) {
      throw Exception('User not authenticated');
    }

    try {
      final url = Uri.parse(
        '${AppConstants.firebaseDatabaseBaseUrl}/users/$_localId/${AppConstants.tasksNode}/${task.id}.json?auth=$_idToken',
      );

      final updatedTask = task.copyWith(updatedAt: DateTime.now());

      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedTask.toJson()),
      );

      if (response.statusCode == 200) {
        return updatedTask;
      } else {
        throw Exception('Failed to update task: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating task: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    if (_localId == null || _idToken == null) {
      throw Exception('User not authenticated');
    }

    try {
      final url = Uri.parse(
        '${AppConstants.firebaseDatabaseBaseUrl}/users/$_localId/${AppConstants.tasksNode}/$taskId.json?auth=$_idToken',
      );

      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception('Failed to delete task: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting task: $e');
    }
  }

  Future<Task> toggleTaskCompletion(Task task) async {
    final updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
      updatedAt: DateTime.now(),
    );
    return await updateTask(updatedTask);
  }
}
