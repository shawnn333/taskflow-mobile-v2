import 'package:dartz/dartz.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/data/datasource/task_local_datasource.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';
import 'package:taskflow_mobile/domain/repositories/task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  LocalTaskRepository(this._dataSource);

  final TaskLocalDataSource _dataSource;

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    try {
      final tasks = await _dataSource.getAllTasks();
      return Right(tasks);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity?>> getTask(String id) async {
    try {
      final tasks = await _dataSource.getAllTasks();
      final match = tasks.where((t) => t.id == id);
      return Right(match.isEmpty ? null : match.first);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getByStatus(bool completed) async {
    try {
      final tasks = await _dataSource.getAllTasks();
      return Right(tasks.where((t) => t.completed == completed).toList());
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> search(String query) async {
    try {
      final tasks = await _dataSource.getAllTasks();
      if (query.trim().isEmpty) return Right(tasks);
      final term = query.toLowerCase().trim();
      return Right(
          tasks.where((t) => t.title.toLowerCase().contains(term)).toList());
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> count() async {
    try {
      final tasks = await _dataSource.getAllTasks();
      return Right(tasks.length);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async {
    try {
      final tasks = await _dataSource.getAllTasks();
      tasks.add(task);
      await _dataSource.saveAllTasks(tasks);
      return const Right(null);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskEntity task) async {
    try {
      final tasks = await _dataSource.getAllTasks();
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index == -1) {
        return Left(ErrorMessage(message: 'Task with ID ${task.id} not found'));
      }
      tasks[index] = task;
      await _dataSource.saveAllTasks(tasks);
      return const Right(null);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeTask(TaskEntity task) async {
    try {
      final tasks = await _dataSource.getAllTasks();
      tasks.removeWhere((t) => t.id == task.id);
      await _dataSource.saveAllTasks(tasks);
      return const Right(null);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleComplete(TaskEntity task) async {
    // Same underlying write as updateTask; kept as a separate repository
    // method to mirror the web app's TaskRepository contract 1:1.
    return updateTask(task);
  }

  @override
  Future<Either<Failure, void>> clearAll() async {
    try {
      await _dataSource.saveAllTasks([]);
      return const Right(null);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }
}
