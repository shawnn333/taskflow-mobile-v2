import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_filters.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/handlers/todo_on_add_task.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/handlers/todo_on_get_all_tasks.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/handlers/todo_on_nav_changed.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/handlers/todo_on_remove_task.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/handlers/todo_on_search_changed.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/handlers/todo_on_toggle_task.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/handlers/todo_on_update_task.dart';

part 'todo_event.dart';
part 'todo_state.dart';
part 'todo_bloc.freezed.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {
    on<_Started>(onGetAllTasks);
    on<_AddTask>(onAddTask);
    on<_UpdateTask>(onUpdateTask);
    on<_RemoveTask>(onRemoveTask);
    on<_ToggleTask>(onToggleTask);
    on<_SearchChanged>(onSearchChanged);
    on<_NavChanged>(onNavChanged);
  }
}
