import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/todo_bloc.dart';
import 'package:taskflow_mobile/core/injection_container.dart';
import 'package:taskflow_mobile/domain/usecases/todo/update_task_usecase.dart';

extension TodoOnUpdateTask on TodoBloc {
  Future<void> onUpdateTask(TodoEvent event, Emitter<TodoState> emit) async {
    final params = event.mapOrNull(updateTask: (e) => e);
    if (params == null) return;

    final updateTask = serviceLocator<UpdateTaskUseCase>();

    final result = await updateTask.execute(id: params.id, title: params.title);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: failure.message?.toString() ?? 'Failed to update task',
      )),
      (updated) {
        final updatedTasks = [
          for (final t in state.tasks) t.id == updated.id ? updated : t,
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
