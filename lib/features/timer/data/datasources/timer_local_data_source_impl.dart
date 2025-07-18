// lib/data/datasources/timer_local_data_source.dart
import 'package:injectable/injectable.dart';
import 'package:odoo/features/timer/data/datasources/timer_local_data_source.dart';
import 'package:odoo/features/timer/domain/entities/project.dart';
import 'package:odoo/features/timer/domain/entities/task.dart';

@LazySingleton(as: TimerLocalDataSource)
class TimerLocalDataSourceImpl implements TimerLocalDataSource {
  // Mock data for projects and tasks
  final List<Project> _projects = [
    Project(id: 'p1', name: 'Apexive: Content Planning'),
    Project(id: 'p2', name: 'Booqio V2'),
  ];
  final List<Task> _tasks = [
    Task(id: 't1', name: 'iOS app deployment', projectId: 'p2'),
    Task(id: 't2', name: 'Get to know Apexer - Ivan', projectId: 'p1'),
  ];

  @override
  Future<List<Project>> getProjects() async => _projects;

  @override
  Future<List<Task>> getTasks() async => _tasks;
}
