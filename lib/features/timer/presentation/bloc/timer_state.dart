import 'package:equatable/equatable.dart';
import 'package:odoo/features/timer/domain/entities/project.dart';
import 'package:odoo/features/timer/domain/entities/task.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';

enum DataStatus { initial, loading, success, failure }

class TimersState extends Equatable {
  /// The master list of all timers.
  final List<TimerEntry> timers;
  final DataStatus timersStatus;

  /// Data required for the 'Create Timer' screen.
  final List<Project> projects;
  final List<Task> tasks;
  final DataStatus creationDataStatus;

  const TimersState({
    this.timers = const <TimerEntry>[],
    this.timersStatus = DataStatus.initial,
    this.projects = const <Project>[],
    this.tasks = const <Task>[],
    this.creationDataStatus = DataStatus.initial,
  });

  TimersState copyWith({
    List<TimerEntry>? timers,
    DataStatus? timersStatus,
    List<Project>? projects,
    List<Task>? tasks,
    DataStatus? creationDataStatus,
  }) {
    return TimersState(
      timers: timers ?? this.timers,
      timersStatus: timersStatus ?? this.timersStatus,
      projects: projects ?? this.projects,
      tasks: tasks ?? this.tasks,
      creationDataStatus: creationDataStatus ?? this.creationDataStatus,
    );
  }

  @override
  List<Object> get props => [
    timers,
    timersStatus,
    projects,
    tasks,
    creationDataStatus,
  ];
}
