import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/todo_bloc.dart';

extension TodoOnSearchChanged on TodoBloc {
  Future<void> onSearchChanged(TodoEvent event, Emitter<TodoState> emit) async {
    final params = event.mapOrNull(searchChanged: (e) => e);
    if (params == null) return;

    // Purely local — the tasks are already loaded, filtering happens at the
    // widget layer via filterTasksForNav(). Mirrors how TodoSearch.jsx just
    // updates Redux's `filter` field without dispatching a fetch.
    emit(state.copyWith(searchQuery: params.query));
  }
}
