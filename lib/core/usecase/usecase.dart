import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class UserLoginParams extends Equatable {
  final String phone;
  final String password;

  const UserLoginParams({
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [phone, password];
}

class UserRegisterParams extends Equatable {
  final String displayName;
  final String phone;
  final int experienceYears;
  final String password;
  final String address;
  final String level;

  const UserRegisterParams({
    required this.displayName,
    required this.experienceYears,
    required this.phone,
    required this.password,
    required this.address,
    required this.level,
  });

  @override
  List<Object?> get props => [
        displayName,
        phone,
        password,
        experienceYears,
        address,
        level,
      ];
}

class CreateTaskParams extends Equatable {
  final String? image;
  final String? title;
  final String? desc;
  final String? priority;
  final String? dueDate;
  final String? id;
  final String? status;

  const CreateTaskParams({
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.dueDate,
    this.id,
    this.status,
  });

  @override
  List<Object?> get props => [
        image,
        title,
        desc,
        priority,
        dueDate,
        id,
        status,
      ];
}

class EditTaskParams extends Equatable {
  final String id;
  final Map<String, dynamic> data;

  const EditTaskParams({
    required this.id,
    required this.data,
  });

  @override
  List<Object?> get props => [id, data];
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
