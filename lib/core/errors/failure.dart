import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final int? code;
  const Failure({this.code});
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({super.code});
}

class CacheFailure extends Failure {}
