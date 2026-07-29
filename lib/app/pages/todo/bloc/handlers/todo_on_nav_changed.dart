import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/todo_bloc.dart';

/// Mirrors handleNavClick in TodoPage.jsx: switching the sidebar/nav filter
/// also clears the active search term.
extension TodoOnNavChanged on TodoBloc {
  Future<void> onNavChanged(TodoEvent event, Emitter<TodoState> emit) async {
    final params = event.mapOrNull(navChanged: (e) => e);
    if (params == null) return;

    emit(state.copyWith(activeNav: params.nav, searchQuery: ''));
  }
}
