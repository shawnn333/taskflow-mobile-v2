import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/todo_bloc.dart';
import 'package:taskflow_mobile/core/injection_container.dart';
import 'package:taskflow_mobile/domain/usecases/todo/add_task_usecase.dart';

extension TodoOnAddTask on TodoBloc {
  Future<void> onAddTask(TodoEvent event, Emitter<TodoState> emit) async {
    final params = event.mapOrNull(addTask: (e) => e);
    if (params == null) return;

    final addTask = serviceLocator<AddTaskUseCase>();

    final result = await addTask.execute(
      title: params.title,
      createdAt: params.createdAt,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: failure.message?.toString() ?? 'Failed to add task',
      )),
      (task) {
        final updatedTasks = [task, ...state.tasks]
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        emit(state.copyWith(
          status: TodoStatus.success,
          tasks: updatedTasks,
          errorMessage: '',
        ));
      },
    );
  }
}
