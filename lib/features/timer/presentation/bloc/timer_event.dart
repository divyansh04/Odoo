import 'package:equatable/equatable.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';

abstract class TimersEvent extends Equatable {
  const TimersEvent();
  @override
  List<Object> get props => [];
}

/// Fetches the data needed for the Create Timer screen (Projects and Tasks).
class FetchCreationData extends TimersEvent {
  const FetchCreationData();
}

/// Adds a new timer to the list.
class AddTimer extends TimersEvent {
  final TimerEntry timer;
  const AddTimer(this.timer);
  @override
  List<Object> get props => [timer];
}

/// Toggles the running state of a specific timer.
class TogglePlayPauseTimer extends TimersEvent {
  final String timerId;
  const TogglePlayPauseTimer(this.timerId);
  @override
  List<Object> get props => [timerId];
}

/// Stops a timer and creates a completed record.
class StopTimer extends TimersEvent {
  final String timerId;
  final String recordDescription;
  const StopTimer(this.timerId, this.recordDescription);
  @override
  List<Object> get props => [timerId, recordDescription];
}
