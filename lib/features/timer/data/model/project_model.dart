import 'package:odoo/features/timer/domain/entities/project.dart';

class ProjectModel extends Project {
  const ProjectModel({required super.id, required super.name});

  factory ProjectModel.fromEntity(Project entity) {
    return ProjectModel(id: entity.id, name: entity.name);
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
