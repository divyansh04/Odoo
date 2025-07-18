// lib/domain/usecases/timer_usecases.dart
import 'package:injectable/injectable.dart';
import 'package:odoo/core/usecases/usecase.dart';
import 'package:odoo/features/timer/domain/entities/project.dart';
import 'package:odoo/features/timer/domain/entities/task.dart';
import 'package:odoo/features/timer/domain/repository/timer_repository.dart';

@injectable
class GetProjectsUseCase implements UseCase<List<Project>, NoParams> {
  final TimerRepository repository;
  GetProjectsUseCase(this.repository);

  @override
  Future<List<Project>> call(NoParams params) async {
    return repository.getProjects();
  }
}

@injectable
class GetTasksUseCase implements UseCase<List<Task>, NoParams> {
  final TimerRepository repository;
  GetTasksUseCase(this.repository);

  @override
  Future<List<Task>> call(NoParams params) async {
    return repository.getTasks();
  }
}
// Other use cases like AddTimer, ToggleTimer, etc. would be defined here.
// For simplicity in the BLoC, we'll let it manage the list operations for now.
// A more complex app would have AddTimerUseCase, etc.