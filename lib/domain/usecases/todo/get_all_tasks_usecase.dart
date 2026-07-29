import 'package:dartz/dartz.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';
import 'package:taskflow_mobile/domain/repositories/task_repository.dart';

/// Mirrors fetchTasksAsync from task.slice.js: fetches the full, unfiltered
/// task list. Search and nav-date filtering happen client-side afterwards
/// (see TodoFilters), same as the web app's getFilteredTasks().
class GetAllTasksUseCase {
  GetAllTasksUseCase(this._repository);

  final TaskRepository _repository;

  Future<Either<Failure, List<TaskEntity>>> execute() {
    return _repository.getAllTasks();
  }
}
