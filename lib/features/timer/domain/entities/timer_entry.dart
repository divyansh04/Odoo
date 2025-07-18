import 'package:equatable/equatable.dart';
import 'package:odoo/features/timer/domain/entities/completed_record.dart';
import 'package:odoo/features/timer/domain/entities/project.dart';
import 'package:odoo/features/timer/domain/entities/task.dart';

class TimerEntry extends Equatable {
  final String id;
  final Project project;
  final Task task;
  final String description;
  final bool isFavorite;
  final bool isRunning;
  final DateTime? startTime;
  final int baseElapsedSeconds;
  final List<CompletedRecord> completedRecords;

  const TimerEntry({
    required this.id,
    required this.project,
    required this.task,
    required this.description,
    this.isFavorite = false,
    this.isRunning = false,
    this.startTime,
    this.baseElapsedSeconds = 0,
    this.completedRecords = const [],
  });

  /// Calculates the total elapsed duration, including any currently running session.
  Duration get totalDuration {
    if (isRunning && startTime != null) {
      final runningDuration = DateTime.now().difference(startTime!);
      return Duration(seconds: baseElapsedSeconds) + runningDuration;
    }
    return Duration(seconds: baseElapsedSeconds);
  }

  /// Creates a copy of this TimerEntry but with the given fields replaced with the new values.
  TimerEntry copyWith({
    String? id,
    Project? project,
    Task? task,
    String? description,
    bool? isFavorite,
    bool? isRunning,
    DateTime? startTime,
    int? baseElapsedSeconds,
    List<CompletedRecord>? completedRecords,
  }) {
    return TimerEntry(
      id: id ?? this.id,
      project: project ?? this.project,
      task: task ?? this.task,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isRunning: isRunning ?? this.isRunning,
      // Use a nullable value for startTime to allow clearing it.
      startTime: isRunning == false ? null : (startTime ?? this.startTime),
      baseElapsedSeconds: baseElapsedSeconds ?? this.baseElapsedSeconds,
      completedRecords: completedRecords ?? this.completedRecords,
    );
  }

  @override
  List<Object?> get props => [
    id,
    project,
    task,
    description,
    isFavorite,
    isRunning,
    startTime,
    baseElapsedSeconds,
    completedRecords,
  ];
}
