import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String name;
  final String projectId;

  const Task({required this.id, required this.name, required this.projectId});

  @override
  List<Object> get props => [id, name, projectId];
}
