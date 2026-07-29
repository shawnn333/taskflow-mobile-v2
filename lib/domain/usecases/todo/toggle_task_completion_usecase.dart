import 'package:dartz/dartz.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';
import 'package:taskflow_mobile/domain/repositories/task_repository.dart';

class ToggleTaskCompletionUseCase {
  ToggleTaskCompletionUseCase(this._repository);

  final TaskRepository _repository;

  Future<Either<Failure, TaskEntity>> execute(String id) async {
    final existingResult = await _repository.getTask(id);

    Failure? lookupFailure;
    TaskEntity? existing;
    existingResult.fold(
      (failure) => lookupFailure = failure,
      (task) => existing = task,
    );

    if (lookupFailure != null) {
      return Left(lookupFailure!);
    }
    if (existing == null) {
      return Left(ErrorMessage(message: 'Task with ID $id not found'));
    }

    final task = existing!;

    // Same rule as the web app: a task dated in the future can't be marked
    // done today.
    if (!task.completed) {
      final today = DateTime.now();
      final todayOnly = DateTime(today.year, today.month, today.day);
      final taskDateOnly =
          DateTime(task.createdAt.year, task.createdAt.month, task.createdAt.day);

      if (taskDateOnly.isAfter(todayOnly)) {
        return const Left(ErrorMessage(
          message:
              'This task is scheduled for tomorrow or a future date and cannot be marked as done today.',
        ));
      }
    }

    final toggled = task.toggleComplete();
    final result = await _repository.toggleComplete(toggled);

    return result.fold(
      (failure) => Left(failure),
      (_) => Right(toggled),
    );
  }
}
