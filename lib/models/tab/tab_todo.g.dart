// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TabTodoImpl _$$TabTodoImplFromJson(Map<String, dynamic> json) =>
    _$TabTodoImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      todos: (json['todos'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList(),
      priority: (json['priority'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$TabTodoImplToJson(_$TabTodoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'todos': instance.todos,
      'priority': instance.priority,
    };
