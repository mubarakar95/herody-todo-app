import '../models/task_model.dart';
import '../services/database_service.dart';

class TaskRepository {
  final DatabaseService _databaseService;

  TaskRepository(this._databaseService);

  Future<List<Task>> getTasks() async {
    return await _databaseService.getTasks();
  }

  Future<Task> addTask(Task task) async {
    return await _databaseService.addTask(task);
  }

  Future<Task> updateTask(Task task) async {
    return await _databaseService.updateTask(task);
  }

  Future<void> deleteTask(String taskId) async {
    await _databaseService.deleteTask(taskId);
  }

  Future<Task> toggleTaskCompletion(Task task) async {
    return await _databaseService.toggleTaskCompletion(task);
  }

  String? get userId => _databaseService.userId;
}
