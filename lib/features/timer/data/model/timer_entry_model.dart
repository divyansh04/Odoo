// --- Data Models ---
// These models are part of the Data Layer. They extend the pure Domain Entities
// to add data-specific functionality, such as converting to and from JSON.
// This keeps the core business logic in the Domain layer completely separate
// from data persistence concerns.

import 'package:odoo/features/timer/data/model/completed_record_model.dart';
import 'package:odoo/features/timer/data/model/project_model.dart';
import 'package:odoo/features/timer/data/model/task_model.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';

/// The Data Model for a `TimerEntry`.
///
/// It is responsible for two main tasks:
/// 1. Extending the `TimerEntry` entity to inherit its properties and business logic.
/// 2. Implementing serialization/deserialization logic (`toJson`, `fromJson`) for storage.
class TimerEntryModel extends TimerEntry {
  const TimerEntryModel({
    required super.id,
    required super.project,
    required super.task,
    required super.description,
    required super.isFavorite,
    required super.isRunning,
    required super.startTime,
    required super.baseElapsedSeconds,
    required super.completedRecords,
  });

  /// Creates a `TimerEntryModel` from a pure `TimerEntry` entity from the Domain layer.
  /// This is a crucial mapping step when data flows from the domain to the data layer
  /// (e.g., before saving state).
  factory TimerEntryModel.fromEntity(TimerEntry entity) {
    return TimerEntryModel(
      id: entity.id,
      // Ensure nested entities are also converted to their corresponding models.
      project: ProjectModel.fromEntity(entity.project),
      task: TaskModel.fromEntity(entity.task),
      description: entity.description,
      isFavorite: entity.isFavorite,
      isRunning: entity.isRunning,
      startTime: entity.startTime,
      baseElapsedSeconds: entity.baseElapsedSeconds,
      completedRecords:
          entity.completedRecords
              .map((record) => CompletedRecordModel.fromEntity(record))
              .toList(),
    );
  }

  /// Creates a `TimerEntryModel` from a JSON object (Map).
  /// This is used when deserializing data that was retrieved from storage.
  factory TimerEntryModel.fromJson(Map<String, dynamic> json) {
    return TimerEntryModel(
      id: json['id'] as String,
      // Deserialize nested JSON objects into their respective models.
      project: ProjectModel.fromJson(json['project'] as Map<String, dynamic>),
      task: TaskModel.fromJson(json['task'] as Map<String, dynamic>),
      description: json['description'] as String,
      isFavorite: json['isFavorite'] as bool,
      isRunning: json['isRunning'] as bool,
      // Safely handle nullable DateTime by checking for null before parsing.
      startTime:
          json['startTime'] != null
              ? DateTime.parse(json['startTime'] as String)
              : null,
      baseElapsedSeconds: json['baseElapsedSeconds'] as int,
      // Deserialize the list of completed records.
      completedRecords:
          (json['completedRecords'] as List<dynamic>)
              .map(
                (recordJson) => CompletedRecordModel.fromJson(
                  recordJson as Map<String, dynamic>,
                ),
              )
              .toList(),
    );
  }

  /// Converts this `TimerEntryModel` instance into a JSON object (Map).
  /// This is used by `HydratedBloc` to serialize the state for persistence.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // Cast nested entities to their model type to call their `toJson` method.
      'project': (project as ProjectModel).toJson(),
      'task': (task as TaskModel).toJson(),
      'description': description,
      'isFavorite': isFavorite,
      'isRunning': isRunning,
      // Safely handle nullable DateTime by converting to string or storing null.
      'startTime': startTime?.toIso8601String(),
      'baseElapsedSeconds': baseElapsedSeconds,
      'completedRecords':
          completedRecords
              .map((record) => (record as CompletedRecordModel).toJson())
              .toList(),
    };
  }
}
