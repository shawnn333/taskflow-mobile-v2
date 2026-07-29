// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TodoEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, DateTime? createdAt) addTask,
    required TResult Function(String id, String title) updateTask,
    required TResult Function(String id) removeTask,
    required TResult Function(String id) toggleTask,
    required TResult Function(String query) searchChanged,
    required TResult Function(NavFilter nav) navChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, DateTime? createdAt)? addTask,
    TResult? Function(String id, String title)? updateTask,
    TResult? Function(String id)? removeTask,
    TResult? Function(String id)? toggleTask,
    TResult? Function(String query)? searchChanged,
    TResult? Function(NavFilter nav)? navChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, DateTime? createdAt)? addTask,
    TResult Function(String id, String title)? updateTask,
    TResult Function(String id)? removeTask,
    TResult Function(String id)? toggleTask,
    TResult Function(String query)? searchChanged,
    TResult Function(NavFilter nav)? navChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddTask value) addTask,
    required TResult Function(_UpdateTask value) updateTask,
    required TResult Function(_RemoveTask value) removeTask,
    required TResult Function(_ToggleTask value) toggleTask,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_NavChanged value) navChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddTask value)? addTask,
    TResult? Function(_UpdateTask value)? updateTask,
    TResult? Function(_RemoveTask value)? removeTask,
    TResult? Function(_ToggleTask value)? toggleTask,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_NavChanged value)? navChanged,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddTask value)? addTask,
    TResult Function(_UpdateTask value)? updateTask,
    TResult Function(_RemoveTask value)? removeTask,
    TResult Function(_ToggleTask value)? toggleTask,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_NavChanged value)? navChanged,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoEventCopyWith<$Res> {
  factory $TodoEventCopyWith(TodoEvent value, $Res Function(TodoEvent) then) =
      _$TodoEventCopyWithImpl<$Res, TodoEvent>;
}

/// @nodoc
class _$TodoEventCopyWithImpl<$Res, $Val extends TodoEvent>
    implements $TodoEventCopyWith<$Res> {
  _$TodoEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$TodoEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'TodoEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, DateTime? createdAt) addTask,
    required TResult Function(String id, String title) updateTask,
    required TResult Function(String id) removeTask,
    required TResult Function(String id) toggleTask,
    required TResult Function(String query) searchChanged,
    required TResult Function(NavFilter nav) navChanged,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, DateTime? createdAt)? addTask,
    TResult? Function(String id, String title)? updateTask,
    TResult? Function(String id)? removeTask,
    TResult? Function(String id)? toggleTask,
    TResult? Function(String query)? searchChanged,
    TResult? Function(NavFilter nav)? navChanged,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, DateTime? createdAt)? addTask,
    TResult Function(String id, String title)? updateTask,
    TResult Function(String id)? removeTask,
    TResult Function(String id)? toggleTask,
    TResult Function(String query)? searchChanged,
    TResult Function(NavFilter nav)? navChanged,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddTask value) addTask,
    required TResult Function(_UpdateTask value) updateTask,
    required TResult Function(_RemoveTask value) removeTask,
    required TResult Function(_ToggleTask value) toggleTask,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_NavChanged value) navChanged,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddTask value)? addTask,
    TResult? Function(_UpdateTask value)? updateTask,
    TResult? Function(_RemoveTask value)? removeTask,
    TResult? Function(_ToggleTask value)? toggleTask,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_NavChanged value)? navChanged,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddTask value)? addTask,
    TResult Function(_UpdateTask value)? updateTask,
    TResult Function(_RemoveTask value)? removeTask,
    TResult Function(_ToggleTask value)? toggleTask,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_NavChanged value)? navChanged,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements TodoEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$AddTaskImplCopyWith<$Res> {
  factory _$$AddTaskImplCopyWith(
          _$AddTaskImpl value, $Res Function(_$AddTaskImpl) then) =
      __$$AddTaskImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String title, DateTime? createdAt});
}

/// @nodoc
class __$$AddTaskImplCopyWithImpl<$Res>
    extends _$TodoEventCopyWithImpl<$Res, _$AddTaskImpl>
    implements _$$AddTaskImplCopyWith<$Res> {
  __$$AddTaskImplCopyWithImpl(
      _$AddTaskImpl _value, $Res Function(_$AddTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$AddTaskImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$AddTaskImpl implements _AddTask {
  const _$AddTaskImpl({required this.title, this.createdAt});

  @override
  final String title;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'TodoEvent.addTask(title: $title, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTaskImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, createdAt);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTaskImplCopyWith<_$AddTaskImpl> get copyWith =>
      __$$AddTaskImplCopyWithImpl<_$AddTaskImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, DateTime? createdAt) addTask,
    required TResult Function(String id, String title) updateTask,
    required TResult Function(String id) removeTask,
    required TResult Function(String id) toggleTask,
    required TResult Function(String query) searchChanged,
    required TResult Function(NavFilter nav) navChanged,
  }) {
    return addTask(title, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, DateTime? createdAt)? addTask,
    TResult? Function(String id, String title)? updateTask,
    TResult? Function(String id)? removeTask,
    TResult? Function(String id)? toggleTask,
    TResult? Function(String query)? searchChanged,
    TResult? Function(NavFilter nav)? navChanged,
  }) {
    return addTask?.call(title, createdAt);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, DateTime? createdAt)? addTask,
    TResult Function(String id, String title)? updateTask,
    TResult Function(String id)? removeTask,
    TResult Function(String id)? toggleTask,
    TResult Function(String query)? searchChanged,
    TResult Function(NavFilter nav)? navChanged,
    required TResult orElse(),
  }) {
    if (addTask != null) {
      return addTask(title, createdAt);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddTask value) addTask,
    required TResult Function(_UpdateTask value) updateTask,
    required TResult Function(_RemoveTask value) removeTask,
    required TResult Function(_ToggleTask value) toggleTask,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_NavChanged value) navChanged,
  }) {
    return addTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddTask value)? addTask,
    TResult? Function(_UpdateTask value)? updateTask,
    TResult? Function(_RemoveTask value)? removeTask,
    TResult? Function(_ToggleTask value)? toggleTask,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_NavChanged value)? navChanged,
  }) {
    return addTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddTask value)? addTask,
    TResult Function(_UpdateTask value)? updateTask,
    TResult Function(_RemoveTask value)? removeTask,
    TResult Function(_ToggleTask value)? toggleTask,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_NavChanged value)? navChanged,
    required TResult orElse(),
  }) {
    if (addTask != null) {
      return addTask(this);
    }
    return orElse();
  }
}

abstract class _AddTask implements TodoEvent {
  const factory _AddTask(
      {required final String title, final DateTime? createdAt}) = _$AddTaskImpl;

  String get title;
  DateTime? get createdAt;

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTaskImplCopyWith<_$AddTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTaskImplCopyWith<$Res> {
  factory _$$UpdateTaskImplCopyWith(
          _$UpdateTaskImpl value, $Res Function(_$UpdateTaskImpl) then) =
      __$$UpdateTaskImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String title});
}

/// @nodoc
class __$$UpdateTaskImplCopyWithImpl<$Res>
    extends _$TodoEventCopyWithImpl<$Res, _$UpdateTaskImpl>
    implements _$$UpdateTaskImplCopyWith<$Res> {
  __$$UpdateTaskImplCopyWithImpl(
      _$UpdateTaskImpl _value, $Res Function(_$UpdateTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
  }) {
    return _then(_$UpdateTaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateTaskImpl implements _UpdateTask {
  const _$UpdateTaskImpl({required this.id, required this.title});

  @override
  final String id;
  @override
  final String title;

  @override
  String toString() {
    return 'TodoEvent.updateTask(id: $id, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTaskImplCopyWith<_$UpdateTaskImpl> get copyWith =>
      __$$UpdateTaskImplCopyWithImpl<_$UpdateTaskImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, DateTime? createdAt) addTask,
    required TResult Function(String id, String title) updateTask,
    required TResult Function(String id) removeTask,
    required TResult Function(String id) toggleTask,
    required TResult Function(String query) searchChanged,
    required TResult Function(NavFilter nav) navChanged,
  }) {
    return updateTask(id, title);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, DateTime? createdAt)? addTask,
    TResult? Function(String id, String title)? updateTask,
    TResult? Function(String id)? removeTask,
    TResult? Function(String id)? toggleTask,
    TResult? Function(String query)? searchChanged,
    TResult? Function(NavFilter nav)? navChanged,
  }) {
    return updateTask?.call(id, title);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, DateTime? createdAt)? addTask,
    TResult Function(String id, String title)? updateTask,
    TResult Function(String id)? removeTask,
    TResult Function(String id)? toggleTask,
    TResult Function(String query)? searchChanged,
    TResult Function(NavFilter nav)? navChanged,
    required TResult orElse(),
  }) {
    if (updateTask != null) {
      return updateTask(id, title);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddTask value) addTask,
    required TResult Function(_UpdateTask value) updateTask,
    required TResult Function(_RemoveTask value) removeTask,
    required TResult Function(_ToggleTask value) toggleTask,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_NavChanged value) navChanged,
  }) {
    return updateTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddTask value)? addTask,
    TResult? Function(_UpdateTask value)? updateTask,
    TResult? Function(_RemoveTask value)? removeTask,
    TResult? Function(_ToggleTask value)? toggleTask,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_NavChanged value)? navChanged,
  }) {
    return updateTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddTask value)? addTask,
    TResult Function(_UpdateTask value)? updateTask,
    TResult Function(_RemoveTask value)? removeTask,
    TResult Function(_ToggleTask value)? toggleTask,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_NavChanged value)? navChanged,
    required TResult orElse(),
  }) {
    if (updateTask != null) {
      return updateTask(this);
    }
    return orElse();
  }
}

abstract class _UpdateTask implements TodoEvent {
  const factory _UpdateTask(
      {required final String id,
      required final String title}) = _$UpdateTaskImpl;

  String get id;
  String get title;

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTaskImplCopyWith<_$UpdateTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RemoveTaskImplCopyWith<$Res> {
  factory _$$RemoveTaskImplCopyWith(
          _$RemoveTaskImpl value, $Res Function(_$RemoveTaskImpl) then) =
      __$$RemoveTaskImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$RemoveTaskImplCopyWithImpl<$Res>
    extends _$TodoEventCopyWithImpl<$Res, _$RemoveTaskImpl>
    implements _$$RemoveTaskImplCopyWith<$Res> {
  __$$RemoveTaskImplCopyWithImpl(
      _$RemoveTaskImpl _value, $Res Function(_$RemoveTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$RemoveTaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RemoveTaskImpl implements _RemoveTask {
  const _$RemoveTaskImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'TodoEvent.removeTask(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemoveTaskImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemoveTaskImplCopyWith<_$RemoveTaskImpl> get copyWith =>
      __$$RemoveTaskImplCopyWithImpl<_$RemoveTaskImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, DateTime? createdAt) addTask,
    required TResult Function(String id, String title) updateTask,
    required TResult Function(String id) removeTask,
    required TResult Function(String id) toggleTask,
    required TResult Function(String query) searchChanged,
    required TResult Function(NavFilter nav) navChanged,
  }) {
    return removeTask(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, DateTime? createdAt)? addTask,
    TResult? Function(String id, String title)? updateTask,
    TResult? Function(String id)? removeTask,
    TResult? Function(String id)? toggleTask,
    TResult? Function(String query)? searchChanged,
    TResult? Function(NavFilter nav)? navChanged,
  }) {
    return removeTask?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, DateTime? createdAt)? addTask,
    TResult Function(String id, String title)? updateTask,
    TResult Function(String id)? removeTask,
    TResult Function(String id)? toggleTask,
    TResult Function(String query)? searchChanged,
    TResult Function(NavFilter nav)? navChanged,
    required TResult orElse(),
  }) {
    if (removeTask != null) {
      return removeTask(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddTask value) addTask,
    required TResult Function(_UpdateTask value) updateTask,
    required TResult Function(_RemoveTask value) removeTask,
    required TResult Function(_ToggleTask value) toggleTask,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_NavChanged value) navChanged,
  }) {
    return removeTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddTask value)? addTask,
    TResult? Function(_UpdateTask value)? updateTask,
    TResult? Function(_RemoveTask value)? removeTask,
    TResult? Function(_ToggleTask value)? toggleTask,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_NavChanged value)? navChanged,
  }) {
    return removeTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddTask value)? addTask,
    TResult Function(_UpdateTask value)? updateTask,
    TResult Function(_RemoveTask value)? removeTask,
    TResult Function(_ToggleTask value)? toggleTask,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_NavChanged value)? navChanged,
    required TResult orElse(),
  }) {
    if (removeTask != null) {
      return removeTask(this);
    }
    return orElse();
  }
}

abstract class _RemoveTask implements TodoEvent {
  const factory _RemoveTask({required final String id}) = _$RemoveTaskImpl;

  String get id;

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemoveTaskImplCopyWith<_$RemoveTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ToggleTaskImplCopyWith<$Res> {
  factory _$$ToggleTaskImplCopyWith(
          _$ToggleTaskImpl value, $Res Function(_$ToggleTaskImpl) then) =
      __$$ToggleTaskImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$ToggleTaskImplCopyWithImpl<$Res>
    extends _$TodoEventCopyWithImpl<$Res, _$ToggleTaskImpl>
    implements _$$ToggleTaskImplCopyWith<$Res> {
  __$$ToggleTaskImplCopyWithImpl(
      _$ToggleTaskImpl _value, $Res Function(_$ToggleTaskImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$ToggleTaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ToggleTaskImpl implements _ToggleTask {
  const _$ToggleTaskImpl({required this.id});

  @override
  final String id;

  @override
  String toString() {
    return 'TodoEvent.toggleTask(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ToggleTaskImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ToggleTaskImplCopyWith<_$ToggleTaskImpl> get copyWith =>
      __$$ToggleTaskImplCopyWithImpl<_$ToggleTaskImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, DateTime? createdAt) addTask,
    required TResult Function(String id, String title) updateTask,
    required TResult Function(String id) removeTask,
    required TResult Function(String id) toggleTask,
    required TResult Function(String query) searchChanged,
    required TResult Function(NavFilter nav) navChanged,
  }) {
    return toggleTask(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, DateTime? createdAt)? addTask,
    TResult? Function(String id, String title)? updateTask,
    TResult? Function(String id)? removeTask,
    TResult? Function(String id)? toggleTask,
    TResult? Function(String query)? searchChanged,
    TResult? Function(NavFilter nav)? navChanged,
  }) {
    return toggleTask?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, DateTime? createdAt)? addTask,
    TResult Function(String id, String title)? updateTask,
    TResult Function(String id)? removeTask,
    TResult Function(String id)? toggleTask,
    TResult Function(String query)? searchChanged,
    TResult Function(NavFilter nav)? navChanged,
    required TResult orElse(),
  }) {
    if (toggleTask != null) {
      return toggleTask(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddTask value) addTask,
    required TResult Function(_UpdateTask value) updateTask,
    required TResult Function(_RemoveTask value) removeTask,
    required TResult Function(_ToggleTask value) toggleTask,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_NavChanged value) navChanged,
  }) {
    return toggleTask(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddTask value)? addTask,
    TResult? Function(_UpdateTask value)? updateTask,
    TResult? Function(_RemoveTask value)? removeTask,
    TResult? Function(_ToggleTask value)? toggleTask,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_NavChanged value)? navChanged,
  }) {
    return toggleTask?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddTask value)? addTask,
    TResult Function(_UpdateTask value)? updateTask,
    TResult Function(_RemoveTask value)? removeTask,
    TResult Function(_ToggleTask value)? toggleTask,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_NavChanged value)? navChanged,
    required TResult orElse(),
  }) {
    if (toggleTask != null) {
      return toggleTask(this);
    }
    return orElse();
  }
}

abstract class _ToggleTask implements TodoEvent {
  const factory _ToggleTask({required final String id}) = _$ToggleTaskImpl;

  String get id;

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ToggleTaskImplCopyWith<_$ToggleTaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchChangedImplCopyWith<$Res> {
  factory _$$SearchChangedImplCopyWith(
          _$SearchChangedImpl value, $Res Function(_$SearchChangedImpl) then) =
      __$$SearchChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchChangedImplCopyWithImpl<$Res>
    extends _$TodoEventCopyWithImpl<$Res, _$SearchChangedImpl>
    implements _$$SearchChangedImplCopyWith<$Res> {
  __$$SearchChangedImplCopyWithImpl(
      _$SearchChangedImpl _value, $Res Function(_$SearchChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
  }) {
    return _then(_$SearchChangedImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchChangedImpl implements _SearchChanged {
  const _$SearchChangedImpl({required this.query});

  @override
  final String query;

  @override
  String toString() {
    return 'TodoEvent.searchChanged(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchChangedImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchChangedImplCopyWith<_$SearchChangedImpl> get copyWith =>
      __$$SearchChangedImplCopyWithImpl<_$SearchChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, DateTime? createdAt) addTask,
    required TResult Function(String id, String title) updateTask,
    required TResult Function(String id) removeTask,
    required TResult Function(String id) toggleTask,
    required TResult Function(String query) searchChanged,
    required TResult Function(NavFilter nav) navChanged,
  }) {
    return searchChanged(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, DateTime? createdAt)? addTask,
    TResult? Function(String id, String title)? updateTask,
    TResult? Function(String id)? removeTask,
    TResult? Function(String id)? toggleTask,
    TResult? Function(String query)? searchChanged,
    TResult? Function(NavFilter nav)? navChanged,
  }) {
    return searchChanged?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, DateTime? createdAt)? addTask,
    TResult Function(String id, String title)? updateTask,
    TResult Function(String id)? removeTask,
    TResult Function(String id)? toggleTask,
    TResult Function(String query)? searchChanged,
    TResult Function(NavFilter nav)? navChanged,
    required TResult orElse(),
  }) {
    if (searchChanged != null) {
      return searchChanged(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddTask value) addTask,
    required TResult Function(_UpdateTask value) updateTask,
    required TResult Function(_RemoveTask value) removeTask,
    required TResult Function(_ToggleTask value) toggleTask,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_NavChanged value) navChanged,
  }) {
    return searchChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddTask value)? addTask,
    TResult? Function(_UpdateTask value)? updateTask,
    TResult? Function(_RemoveTask value)? removeTask,
    TResult? Function(_ToggleTask value)? toggleTask,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_NavChanged value)? navChanged,
  }) {
    return searchChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddTask value)? addTask,
    TResult Function(_UpdateTask value)? updateTask,
    TResult Function(_RemoveTask value)? removeTask,
    TResult Function(_ToggleTask value)? toggleTask,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_NavChanged value)? navChanged,
    required TResult orElse(),
  }) {
    if (searchChanged != null) {
      return searchChanged(this);
    }
    return orElse();
  }
}

abstract class _SearchChanged implements TodoEvent {
  const factory _SearchChanged({required final String query}) =
      _$SearchChangedImpl;

  String get query;

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchChangedImplCopyWith<_$SearchChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NavChangedImplCopyWith<$Res> {
  factory _$$NavChangedImplCopyWith(
          _$NavChangedImpl value, $Res Function(_$NavChangedImpl) then) =
      __$$NavChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NavFilter nav});
}

/// @nodoc
class __$$NavChangedImplCopyWithImpl<$Res>
    extends _$TodoEventCopyWithImpl<$Res, _$NavChangedImpl>
    implements _$$NavChangedImplCopyWith<$Res> {
  __$$NavChangedImplCopyWithImpl(
      _$NavChangedImpl _value, $Res Function(_$NavChangedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? nav = null,
  }) {
    return _then(_$NavChangedImpl(
      nav: null == nav
          ? _value.nav
          : nav // ignore: cast_nullable_to_non_nullable
              as NavFilter,
    ));
  }
}

/// @nodoc

class _$NavChangedImpl implements _NavChanged {
  const _$NavChangedImpl({required this.nav});

  @override
  final NavFilter nav;

  @override
  String toString() {
    return 'TodoEvent.navChanged(nav: $nav)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NavChangedImpl &&
            (identical(other.nav, nav) || other.nav == nav));
  }

  @override
  int get hashCode => Object.hash(runtimeType, nav);

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NavChangedImplCopyWith<_$NavChangedImpl> get copyWith =>
      __$$NavChangedImplCopyWithImpl<_$NavChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String title, DateTime? createdAt) addTask,
    required TResult Function(String id, String title) updateTask,
    required TResult Function(String id) removeTask,
    required TResult Function(String id) toggleTask,
    required TResult Function(String query) searchChanged,
    required TResult Function(NavFilter nav) navChanged,
  }) {
    return navChanged(nav);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String title, DateTime? createdAt)? addTask,
    TResult? Function(String id, String title)? updateTask,
    TResult? Function(String id)? removeTask,
    TResult? Function(String id)? toggleTask,
    TResult? Function(String query)? searchChanged,
    TResult? Function(NavFilter nav)? navChanged,
  }) {
    return navChanged?.call(nav);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String title, DateTime? createdAt)? addTask,
    TResult Function(String id, String title)? updateTask,
    TResult Function(String id)? removeTask,
    TResult Function(String id)? toggleTask,
    TResult Function(String query)? searchChanged,
    TResult Function(NavFilter nav)? navChanged,
    required TResult orElse(),
  }) {
    if (navChanged != null) {
      return navChanged(nav);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_AddTask value) addTask,
    required TResult Function(_UpdateTask value) updateTask,
    required TResult Function(_RemoveTask value) removeTask,
    required TResult Function(_ToggleTask value) toggleTask,
    required TResult Function(_SearchChanged value) searchChanged,
    required TResult Function(_NavChanged value) navChanged,
  }) {
    return navChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_AddTask value)? addTask,
    TResult? Function(_UpdateTask value)? updateTask,
    TResult? Function(_RemoveTask value)? removeTask,
    TResult? Function(_ToggleTask value)? toggleTask,
    TResult? Function(_SearchChanged value)? searchChanged,
    TResult? Function(_NavChanged value)? navChanged,
  }) {
    return navChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_AddTask value)? addTask,
    TResult Function(_UpdateTask value)? updateTask,
    TResult Function(_RemoveTask value)? removeTask,
    TResult Function(_ToggleTask value)? toggleTask,
    TResult Function(_SearchChanged value)? searchChanged,
    TResult Function(_NavChanged value)? navChanged,
    required TResult orElse(),
  }) {
    if (navChanged != null) {
      return navChanged(this);
    }
    return orElse();
  }
}

abstract class _NavChanged implements TodoEvent {
  const factory _NavChanged({required final NavFilter nav}) = _$NavChangedImpl;

  NavFilter get nav;

  /// Create a copy of TodoEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NavChangedImplCopyWith<_$NavChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TodoState {
  List<TaskEntity> get tasks => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  NavFilter get activeNav => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  TodoStatus? get status => throw _privateConstructorUsedError;

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoStateCopyWith<TodoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoStateCopyWith<$Res> {
  factory $TodoStateCopyWith(TodoState value, $Res Function(TodoState) then) =
      _$TodoStateCopyWithImpl<$Res, TodoState>;
  @useResult
  $Res call(
      {List<TaskEntity> tasks,
      String searchQuery,
      NavFilter activeNav,
      bool isLoading,
      String errorMessage,
      TodoStatus? status});
}

/// @nodoc
class _$TodoStateCopyWithImpl<$Res, $Val extends TodoState>
    implements $TodoStateCopyWith<$Res> {
  _$TodoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? searchQuery = null,
    Object? activeNav = null,
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskEntity>,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      activeNav: null == activeNav
          ? _value.activeNav
          : activeNav // ignore: cast_nullable_to_non_nullable
              as NavFilter,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TodoStatus?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoStateImplCopyWith<$Res>
    implements $TodoStateCopyWith<$Res> {
  factory _$$TodoStateImplCopyWith(
          _$TodoStateImpl value, $Res Function(_$TodoStateImpl) then) =
      __$$TodoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TaskEntity> tasks,
      String searchQuery,
      NavFilter activeNav,
      bool isLoading,
      String errorMessage,
      TodoStatus? status});
}

/// @nodoc
class __$$TodoStateImplCopyWithImpl<$Res>
    extends _$TodoStateCopyWithImpl<$Res, _$TodoStateImpl>
    implements _$$TodoStateImplCopyWith<$Res> {
  __$$TodoStateImplCopyWithImpl(
      _$TodoStateImpl _value, $Res Function(_$TodoStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tasks = null,
    Object? searchQuery = null,
    Object? activeNav = null,
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? status = freezed,
  }) {
    return _then(_$TodoStateImpl(
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<TaskEntity>,
      searchQuery: null == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String,
      activeNav: null == activeNav
          ? _value.activeNav
          : activeNav // ignore: cast_nullable_to_non_nullable
              as NavFilter,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TodoStatus?,
    ));
  }
}

/// @nodoc

class _$TodoStateImpl implements _TodoState {
  const _$TodoStateImpl(
      {final List<TaskEntity> tasks = const <TaskEntity>[],
      this.searchQuery = '',
      this.activeNav = NavFilter.all,
      this.isLoading = false,
      this.errorMessage = '',
      this.status = null})
      : _tasks = tasks;

  final List<TaskEntity> _tasks;
  @override
  @JsonKey()
  List<TaskEntity> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  @JsonKey()
  final String searchQuery;
  @override
  @JsonKey()
  final NavFilter activeNav;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final TodoStatus? status;

  @override
  String toString() {
    return 'TodoState(tasks: $tasks, searchQuery: $searchQuery, activeNav: $activeNav, isLoading: $isLoading, errorMessage: $errorMessage, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoStateImpl &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.activeNav, activeNav) ||
                other.activeNav == activeNav) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tasks),
      searchQuery,
      activeNav,
      isLoading,
      errorMessage,
      status);

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoStateImplCopyWith<_$TodoStateImpl> get copyWith =>
      __$$TodoStateImplCopyWithImpl<_$TodoStateImpl>(this, _$identity);
}

abstract class _TodoState implements TodoState {
  const factory _TodoState(
      {final List<TaskEntity> tasks,
      final String searchQuery,
      final NavFilter activeNav,
      final bool isLoading,
      final String errorMessage,
      final TodoStatus? status}) = _$TodoStateImpl;

  @override
  List<TaskEntity> get tasks;
  @override
  String get searchQuery;
  @override
  NavFilter get activeNav;
  @override
  bool get isLoading;
  @override
  String get errorMessage;
  @override
  TodoStatus? get status;

  /// Create a copy of TodoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoStateImplCopyWith<_$TodoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
