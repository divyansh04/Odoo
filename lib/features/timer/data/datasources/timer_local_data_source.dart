import 'package:odoo/features/timer/domain/entities/project.dart';
import 'package:odoo/features/timer/domain/entities/task.dart';

abstract class TimerLocalDataSource {
  Future<List<Project>> getProjects();
  Future<List<Task>> getTasks();
}
