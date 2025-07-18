import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:odoo/core/usecases/usecase.dart';
import 'package:odoo/features/timer/data/model/timer_entry_model.dart';
import 'package:odoo/features/timer/domain/entities/completed_record.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';
import 'package:odoo/features/timer/domain/usecases/timer_usecases.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_event.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_state.dart';

@injectable
class TimersBloc extends HydratedBloc<TimersEvent, TimersState> {
  final GetProjectsUseCase _getProjects;
  final GetTasksUseCase _getTasks;

  TimersBloc({
    required GetProjectsUseCase getProjects,
    required GetTasksUseCase getTasks,
  }) : _getProjects = getProjects,
       _getTasks = getTasks,
       super(const TimersState()) {
    on<FetchCreationData>(_onFetchCreationData);
    on<AddTimer>(_onAddTimer);
    on<TogglePlayPauseTimer>(_onTogglePlayPauseTimer);
    on<StopTimer>(_onStopTimer);
  }

  Future<void> _onFetchCreationData(
    FetchCreationData event,
    Emitter<TimersState> emit,
  ) async {
    if (state.projects.isNotEmpty) return;

    emit(state.copyWith(creationDataStatus: DataStatus.loading));
    try {
      final projects = await _getProjects(NoParams());
      final tasks = await _getTasks(NoParams());
      emit(
        state.copyWith(
          projects: projects,
          tasks: tasks,
          creationDataStatus: DataStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(creationDataStatus: DataStatus.failure));
    }
  }

  void _onAddTimer(AddTimer event, Emitter<TimersState> emit) {
    final updatedList = List<TimerEntry>.from(state.timers)..add(event.timer);
    emit(state.copyWith(timers: updatedList, timersStatus: DataStatus.success));
  }

  void _onTogglePlayPauseTimer(
    TogglePlayPauseTimer event,
    Emitter<TimersState> emit,
  ) {
    final updatedList =
        state.timers.map((timer) {
          if (timer.id == event.timerId) {
            return timer.isRunning
                ? timer.copyWith(
                  isRunning: false,
                  baseElapsedSeconds: timer.totalDuration.inSeconds,
                )
                : timer.copyWith(isRunning: true, startTime: DateTime.now());
          }
          return timer;
        }).toList();
    emit(state.copyWith(timers: updatedList));
  }

  void _onStopTimer(StopTimer event, Emitter<TimersState> emit) {
    final updatedList =
        state.timers.map((timer) {
          if (timer.id == event.timerId && timer.isRunning) {
            final newRecord = CompletedRecord(
              date: DateTime.now(),
              duration: timer.totalDuration,
              description: event.recordDescription,
            );
            return timer.copyWith(
              isRunning: false,
              baseElapsedSeconds: 0,
              completedRecords: List.from(timer.completedRecords)
                ..add(newRecord),
            );
          }
          return timer;
        }).toList();
    emit(state.copyWith(timers: updatedList));
  }

  @override
  TimersState? fromJson(Map<String, dynamic> json) {
    try {
      final timers =
          (json['timers'] as List)
              .map((e) => TimerEntryModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return TimersState(timers: timers, timersStatus: DataStatus.success);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TimersState state) {
    final timerModels =
        state.timers
            .map((e) => TimerEntryModel.fromEntity(e).toJson())
            .toList();
    return {'timers': timerModels};
  }
}
