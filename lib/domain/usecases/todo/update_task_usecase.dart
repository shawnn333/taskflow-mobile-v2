import 'package:dartz/dartz.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';
import 'package:taskflow_mobile/domain/repositories/task_repository.dart';

class UpdateTaskUseCase {
  UpdateTaskUseCase(this._repository);

  final TaskRepository _repository;

  Future<Either<Failure, TaskEntity>> execute({
    required String id,
    required String title,
  }) async {
    if (title.trim().isEmpty) {
      return const Left(ErrorMessage(message: 'Task title cannot be empty'));
    }

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

    final updated = existing!.updateTitle(title);
    final updateResult = await _repository.updateTask(updated);

    return updateResult.fold(
      (failure) => Left(failure),
      (_) => Right(updated),
    );
  }
}
