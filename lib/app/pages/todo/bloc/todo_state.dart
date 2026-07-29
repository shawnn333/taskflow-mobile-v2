part of 'todo_bloc.dart';

@freezed
class TodoState with _$TodoState {
  const factory TodoState({
    @Default(<TaskEntity>[]) List<TaskEntity> tasks,
    @Default('') String searchQuery,
    @Default(NavFilter.all) NavFilter activeNav,
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    @Default(null) TodoStatus? status,
  }) = _TodoState;
}

enum TodoStatus { success, error }
