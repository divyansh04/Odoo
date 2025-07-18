import 'package:equatable/equatable.dart';

class CompletedRecord extends Equatable {
  final DateTime date;
  final Duration duration;
  final String description;

  const CompletedRecord({
    required this.date,
    required this.duration,
    this.description = '',
  });

  @override
  List<Object> get props => [date, duration, description];
}
