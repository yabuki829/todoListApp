// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tab_todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TabTodo _$TabTodoFromJson(Map<String, dynamic> json) {
  return _TabTodo.fromJson(json);
}

/// @nodoc
mixin _$TabTodo {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;

  /// Serializes this TabTodo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TabTodo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TabTodoCopyWith<TabTodo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TabTodoCopyWith<$Res> {
  factory $TabTodoCopyWith(TabTodo value, $Res Function(TabTodo) then) =
      _$TabTodoCopyWithImpl<$Res, TabTodo>;
  @useResult
  $Res call({String id, String title, int priority});
}

/// @nodoc
class _$TabTodoCopyWithImpl<$Res, $Val extends TabTodo>
    implements $TabTodoCopyWith<$Res> {
  _$TabTodoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TabTodo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? priority = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TabTodoImplCopyWith<$Res> implements $TabTodoCopyWith<$Res> {
  factory _$$TabTodoImplCopyWith(
          _$TabTodoImpl value, $Res Function(_$TabTodoImpl) then) =
      __$$TabTodoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, int priority});
}

/// @nodoc
class __$$TabTodoImplCopyWithImpl<$Res>
    extends _$TabTodoCopyWithImpl<$Res, _$TabTodoImpl>
    implements _$$TabTodoImplCopyWith<$Res> {
  __$$TabTodoImplCopyWithImpl(
      _$TabTodoImpl _value, $Res Function(_$TabTodoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TabTodo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? priority = null,
  }) {
    return _then(_$TabTodoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TabTodoImpl implements _TabTodo {
  const _$TabTodoImpl(
      {required this.id, required this.title, this.priority = 0});

  factory _$TabTodoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TabTodoImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final int priority;

  @override
  String toString() {
    return 'TabTodo(id: $id, title: $title, priority: $priority)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TabTodoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.priority, priority) ||
                other.priority == priority));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, priority);

  /// Create a copy of TabTodo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TabTodoImplCopyWith<_$TabTodoImpl> get copyWith =>
      __$$TabTodoImplCopyWithImpl<_$TabTodoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TabTodoImplToJson(
      this,
    );
  }
}

abstract class _TabTodo implements TabTodo {
  const factory _TabTodo(
      {required final String id,
      required final String title,
      final int priority}) = _$TabTodoImpl;

  factory _TabTodo.fromJson(Map<String, dynamic> json) = _$TabTodoImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  int get priority;

  /// Create a copy of TabTodo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TabTodoImplCopyWith<_$TabTodoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
