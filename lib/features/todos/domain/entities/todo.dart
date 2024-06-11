import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  const Todo({
    required this.id,
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  @override
  List<Object?> get props => [
        id,
        image,
        title,
        desc,
        priority,
        status,
        user,
        createdAt,
        updatedAt,
        v,
      ];
}