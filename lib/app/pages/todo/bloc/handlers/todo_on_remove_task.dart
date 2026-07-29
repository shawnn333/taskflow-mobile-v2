import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/todo_bloc.dart';
import 'package:taskflow_mobile/core/injection_container.dart';
import 'package:taskflow_mobile/domain/usecases/todo/remove_task_usecase.dart';

extension TodoOnRemoveTask on TodoBloc {
  Future<void> onRemoveTask(TodoEvent event, Emitter<TodoState> emit) async {
    final params = event.mapOrNull(removeTask: (e) => e);
    if (params == null) return;

    final removeTask = serviceLocator<RemoveTaskUseCase>();

    final result = await removeTask.execute(params.id);

    result.fold(
      (failure) => emit(state.copyWith(
        status: TodoStatus.error,
        errorMessage: failure.message?.toString() ?? 'Failed to delete task',
      )),
      (removedId) {
        final remaining = state.tasks.where((t) => t.id != removedId).toList();
        emit(state.copyWith(
          status: TodoStatus.success,
          tasks: remaining,
          errorMessage: '',
        ));
      },
    );
  }
}
