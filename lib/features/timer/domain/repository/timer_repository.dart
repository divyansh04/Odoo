import 'package:odoo/features/timer/domain/entities/project.dart';
import 'package:odoo/features/timer/domain/entities/task.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';

abstract class TimerRepository {
  Future<List<Project>> getProjects();
  Future<List<Task>> getTasks();
  Future<void> saveTimers(List<TimerEntry> timers);
  Future<List<TimerEntry>> getTimers();
}
