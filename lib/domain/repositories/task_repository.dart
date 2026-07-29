import 'package:dartz/dartz.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';

/// TaskRepository - typed domain contract, mirrored from the web app's
/// domain/repositories/TaskRepository.ts.
///
/// Per team convention (same one Clapton enforces on the web app):
/// mutation methods take the full entity and return void (here, wrapped in
/// Either<Failure, void>). Callers already hold the entity they
/// created/mutated, so nothing needs to be handed back.
abstract class TaskRepository {
  Future<Either<Failure, List<TaskEntity>>> getAllTasks();
  Future<Either<Failure, TaskEntity?>> getTask(String id);
  Future<Either<Failure, List<TaskEntity>>> getByStatus(bool completed);
  Future<Either<Failure, List<TaskEntity>>> search(String query);
  Future<Either<Failure, int>> count();

  Future<Either<Failure, void>> addTask(TaskEntity task);
  Future<Either<Failure, void>> updateTask(TaskEntity task);
  Future<Either<Failure, void>> removeTask(TaskEntity task);
  Future<Either<Failure, void>> toggleComplete(TaskEntity task);
  Future<Either<Failure, void>> clearAll();
}
