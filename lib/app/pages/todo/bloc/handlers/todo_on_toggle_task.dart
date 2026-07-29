import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/todo_bloc.dart';
import 'package:taskflow_mobile/core/injection_container.dart';
import 'package:taskflow_mobile/domain/usecases/todo/toggle_task_completion_usecase.dart';

extension TodoOnToggleTask on TodoBloc {
  Future<void> onToggleTask(TodoEvent event, Emitter<TodoState> emit) async {
    final params = event.mapOrNull(toggleTask: (e) => e);
    if (params == null) return;

    final toggleTask = serviceLocator<ToggleTaskCompletionUseCase>();

    final result = await toggleTask.execute(params.id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: failure.message?.toString() ?? 'Failed to update task',
      )),
      (toggled) {
        final updatedTasks = [
          for (final t in state.tasks) t.id == toggled.id ? toggled : t,
        ];
        emit(state.copyWith(
          status: TodoStatus.success,
          tasks: updatedTasks,
          errorMessage: '',
        ));
      },
    );
  }
}
