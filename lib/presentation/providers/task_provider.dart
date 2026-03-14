import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference? _tasksRef;

  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<Task> get tasks => _tasks;
  List<Task> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();
  List<Task> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasTasks => _tasks.isNotEmpty;

  void setUserId(String userId) {
    _tasksRef = _database.ref().child('users/$userId/tasks');
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    if (_tasksRef == null) {
      _error = 'User not authenticated';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final snapshot = await _tasksRef!.get();

      if (snapshot.exists && snapshot.value != null) {
        final Map<dynamic, dynamic> data =
            snapshot.value as Map<dynamic, dynamic>;
        _tasks = [];

        data.forEach((key, value) {
          final taskData = Map<String, dynamic>.from(value);
          taskData['id'] = key;
          _tasks.add(Task.fromJson(taskData));
        });

        // Sort by creation date (newest first)
        _tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else {
        _tasks = [];
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addTask(String title, String description) async {
    if (_tasksRef == null) {
      _error = 'User not authenticated';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final taskId = const Uuid().v4();
      final task = Task(
        id: taskId,
        title: title,
        description: description,
        isCompleted: false,
        createdAt: DateTime.now(),
      );

      await _tasksRef!.child(taskId).set(task.toJson());
      _tasks.insert(0, task);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTask(
    Task task,
    String newTitle,
    String newDescription,
  ) async {
    if (_tasksRef == null) {
      _error = 'User not authenticated';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final updatedTask = task.copyWith(
        title: newTitle,
        description: newDescription,
        updatedAt: DateTime.now(),
      );

      await _tasksRef!.child(task.id).update(updatedTask.toJson());

      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = updatedTask;
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> toggleTaskCompletion(Task task) async {
    if (_tasksRef == null) {
      _error = 'User not authenticated';
      notifyListeners();
      return false;
    }

    try {
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
        updatedAt: DateTime.now(),
      );

      await _tasksRef!.child(task.id).update(updatedTask.toJson());

      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = updatedTask;
      }

      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTask(String taskId) async {
    if (_tasksRef == null) {
      _error = 'User not authenticated';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _tasksRef!.child(taskId).remove();
      _tasks.removeWhere((task) => task.id == taskId);

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearTasks() {
    _tasks = [];
    _error = null;
    notifyListeners();
  }
}
