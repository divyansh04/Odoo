import 'package:injectable/injectable.dart';
import 'package:odoo/features/timer/data/datasources/timer_local_data_source.dart';
import 'package:odoo/features/timer/domain/entities/project.dart';
import 'package:odoo/features/timer/domain/entities/task.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';
import 'package:odoo/features/timer/domain/repository/timer_repository.dart';

@LazySingleton(as: TimerRepository)
class TimerRepositoryImpl implements TimerRepository {
  final TimerLocalDataSource localDataSource;

  TimerRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Project>> getProjects() async {
    return localDataSource.getProjects();
  }

  @override
  Future<List<Task>> getTasks() async {
    return localDataSource.getTasks();
  }

  // In a real app, these would interact with the data source
  @override
  Future<List<TimerEntry>> getTimers() async {
    // For HydratedBloc, this isn't strictly needed as it handles its own persistence.
    // This would be used for fetching from a DB or API.
    return [];
  }

  @override
  Future<void> saveTimers(List<TimerEntry> timers) async {
    // This would save the list of timers to a local DB.
  }
}
