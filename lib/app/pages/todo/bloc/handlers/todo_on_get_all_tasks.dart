import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/todo_bloc.dart';
import 'package:taskflow_mobile/core/injection_container.dart';
import 'package:taskflow_mobile/domain/usecases/todo/get_all_tasks_usecase.dart';

extension TodoOnGetAllTasks on TodoBloc {
  Future<void> onGetAllTasks(TodoEvent event, Emitter<TodoState> emit) async {
    final getAllTasks = serviceLocator<GetAllTasksUseCase>();

    emit(state.copyWith(isLoading: true, status: null, errorMessage: ''));

    // Fetch the full list; search/nav filtering happens client-side (in
    // todo_filters.dart) same as the React app's Redux-selector filtering,
    // so switching nav tabs or typing a search term doesn't need a refetch.
    final result = await getAllTasks.execute();

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        status: TodoStatus.error,
        errorMessage: failure.message?.toString() ?? 'Failed to load tasks',
      )),
      (tasks) => emit(state.copyWith(
        isLoading: false,
        status: TodoStatus.success,
        tasks: tasks,
        errorMessage: '',
      )),
    );
  }
}
