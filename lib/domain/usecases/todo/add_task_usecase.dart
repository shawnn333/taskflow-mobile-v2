import 'package:dartz/dartz.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';
import 'package:taskflow_mobile/domain/repositories/task_repository.dart';

class AddTaskUseCase {
  AddTaskUseCase(this._repository);

  final TaskRepository _repository;

  Future<Either<Failure, TaskEntity>> execute({
    required String title,
    DateTime? createdAt,
  }) async {
    if (title.trim().isEmpty) {
      return const Left(ErrorMessage(message: 'Task title cannot be empty'));
    }

    try {
      final task = TaskEntity.create(title: title.trim(), createdAt: createdAt);
      final result = await _repository.addTask(task);
      return result.fold(
        (failure) => Left(failure),
        (_) => Right(task),
      );
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }
}
