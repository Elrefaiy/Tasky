import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.image,
    required super.title,
    required super.desc,
    required super.priority,
    required super.status,
    required super.user,
    required super.createdAt,
    required super.updatedAt,
    required super.v,
  });
  factory TodoModel.fromjson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['_id'],
      image: json['image'],
      title: json['title'],
      desc: json['desc'],
      priority: json['priority'],
      status: json['status'],
      user: json['user'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

}
