part of 'todo_bloc.dart';

@freezed
class TodoEvent with _$TodoEvent {
  const factory TodoEvent.started() = _Started;

  const factory TodoEvent.addTask({
    required String title,
    DateTime? createdAt,
  }) = _AddTask;

  const factory TodoEvent.updateTask({
    required String id,
    required String title,
  }) = _UpdateTask;

  const factory TodoEvent.removeTask({
    required String id,
  }) = _RemoveTask;

  const factory TodoEvent.toggleTask({
    required String id,
  }) = _ToggleTask;

  const factory TodoEvent.searchChanged({
    required String query,
  }) = _SearchChanged;

  const factory TodoEvent.navChanged({
    required NavFilter nav,
  }) = _NavChanged;
}
