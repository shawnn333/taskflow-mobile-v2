import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';
import 'package:taskflow_mobile/domain/repositories/task_repository.dart';
import 'package:taskflow_mobile/domain/usecases/todo/toggle_task_completion_usecase.dart';

/// Minimal in-memory fake standing in for LocalTaskRepository, so this test
/// exercises use-case logic only (no SharedPreferences plugin needed).
class _FakeTaskRepository implements TaskRepository {
  final List<TaskEntity> tasks;
  _FakeTaskRepository(this.tasks);

  @override
  Future<Either<Failure, TaskEntity?>> getTask(String id) async {
    final match = tasks.where((t) => t.id == id);
    return Right(match.isEmpty ? null : match.first);
  }

  @override
  Future<Either<Failure, void>> toggleComplete(TaskEntity task) async {
    final index = tasks.indexWhere((t) => t.id == task.id);
    tasks[index] = task;
    return const Right(null);
  }

  // Unused by this test but required by the interface.
  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async => const Right(null);
  @override
  Future<Either<Failure, void>> clearAll() async => const Right(null);
  @override
  Future<Either<Failure, int>> count() async => Right(tasks.length);
  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async => Right(tasks);
  @override
  Future<Either<Failure, List<TaskEntity>>> getByStatus(bool completed) async =>
      Right(tasks.where((t) => t.completed == completed).toList());
  @override
  Future<Either<Failure, List<TaskEntity>>> search(String query) async => Right(tasks);
  @override
  Future<Either<Failure, void>> removeTask(TaskEntity task) async => const Right(null);
  @override
  Future<Either<Failure, void>> updateTask(TaskEntity task) async => const Right(null);
}

void main() {
  test('marks a task completed when it is due today or earlier', () async {
    final task = TaskEntity.create(title: 'Due today');
    final repo = _FakeTaskRepository([task]);
    final useCase = ToggleTaskCompletionUseCase(repo);

    final result = await useCase.execute(task.id);

    expect(result.isRight(), true);
    result.fold((_) => fail('expected Right'), (t) => expect(t.completed, true));
  });

  test('refuses to complete a task scheduled for a future date', () async {
    final futureDate = DateTime.now().add(const Duration(days: 3));
    final task = TaskEntity.create(title: 'Due later', createdAt: futureDate);
    final repo = _FakeTaskRepository([task]);
    final useCase = ToggleTaskCompletionUseCase(repo);

    final result = await useCase.execute(task.id);

    expect(result.isLeft(), true);
    result.fold(
      (failure) => expect(
        failure.message.toString(),
        contains('future date'),
      ),
      (_) => fail('expected Left'),
    );
  });
}
