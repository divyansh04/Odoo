import 'package:odoo/features/timer/domain/entities/completed_record.dart';

/// The Data Model for a `CompletedRecord`.
class CompletedRecordModel extends CompletedRecord {
  const CompletedRecordModel({
    required super.date,
    required super.duration,
    required super.description,
  });

  factory CompletedRecordModel.fromEntity(CompletedRecord entity) {
    return CompletedRecordModel(
      date: entity.date,
      duration: entity.duration,
      description: entity.description,
    );
  }

  factory CompletedRecordModel.fromJson(Map<String, dynamic> json) {
    return CompletedRecordModel(
      date: DateTime.parse(json['date'] as String),
      duration: Duration(seconds: json['duration'] as int),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'duration': duration.inSeconds,
      'description': description,
    };
  }
}
