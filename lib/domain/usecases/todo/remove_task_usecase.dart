import 'package:dartz/dartz.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';
import 'package:taskflow_mobile/domain/repositories/task_repository.dart';

class RemoveTaskUseCase {
  RemoveTaskUseCase(this._repository);

  final TaskRepository _repository;

  Future<Either<Failure, String>> execute(String id) async {
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

    final removeResult = await _repository.removeTask(existing!);
    return removeResult.fold(
      (failure) => Left(failure),
      (_) => Right(id),
    );
  }
}
