import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo/core/config/app_colors.dart';
import 'package:odoo/core/config/app_theme.dart';
import 'package:odoo/features/timer/domain/entities/project.dart';
import 'package:odoo/features/timer/domain/entities/task.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_event.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_state.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/bakcground_gradient_container.dart';
import 'package:uuid/uuid.dart';

class CreateTimerScreen extends StatefulWidget {
  const CreateTimerScreen({super.key});

  @override
  State<CreateTimerScreen> createState() => _CreateTimerScreenState();
}

class _CreateTimerScreenState extends State<CreateTimerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();

  Project? _selectedProject;
  Task? _selectedTask;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Dispatch an event to the BLoC to fetch the necessary data for the dropdowns.
    context.read<TimersBloc>().add(const FetchCreationData());
  }

  /// Validates the form and dispatches an event to add the new timer.
  void _createTimer() {
    if (_formKey.currentState!.validate()) {
      final newTimer = TimerEntry(
        id: const Uuid().v4(),
        project: _selectedProject!,
        task: _selectedTask!,
        description: _descController.text,
        isFavorite: _isFavorite,
      );
      context.read<TimersBloc>().add(AddTimer(newTimer));
      // Return to the previous screen after creation.
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundGradientContainer(
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Timer')),
        // Use BlocBuilder to react to state changes, such as data loading for dropdowns.
        body: BlocBuilder<TimersBloc, TimersState>(
          builder: (context, state) {
            // Show a loading indicator while fetching projects and tasks.
            if (state.creationDataStatus == DataStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Show an error message if data fetching fails.
            if (state.creationDataStatus == DataStatus.failure) {
              return const Center(child: Text('Failed to load data.'));
            }

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildProjectDropdown(state.projects),
                    const SizedBox(height: 16),
                    _buildTaskDropdown(state.tasks),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                      minLines: 3,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 16),
                    CheckboxListTile(
                      title: const Text('Make Favorite'),
                      value: _isFavorite,
                      onChanged: (val) => setState(() => _isFavorite = val!),
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: AppColors.primary,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: _createTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Create Timer',
                        style: AppTypography.textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds the dropdown for selecting a project.
  Widget _buildProjectDropdown(List<Project> projects) {
    return DropdownButtonFormField<Project>(
      value: _selectedProject,
      decoration: const InputDecoration(hintText: 'Project'),
      items:
          projects
              .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
              .toList(),
      onChanged: (val) {
        setState(() {
          _selectedProject = val;
          // Reset task selection when the project changes.
          _selectedTask = null;
        });
      },
      validator: (val) => val == null ? 'Please select a project' : null,
    );
  }

  /// Builds the dropdown for selecting a task, filtered by the selected project.
  Widget _buildTaskDropdown(List<Task> tasks) {
    final availableTasks =
        _selectedProject == null
            ? <Task>[]
            : tasks.where((t) => t.projectId == _selectedProject!.id).toList();

    return DropdownButtonFormField<Task>(
      value: _selectedTask,
      decoration: const InputDecoration(hintText: 'Task'),
      items:
          availableTasks
              .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
              .toList(),
      // Disable the dropdown if no project is selected.
      onChanged:
          _selectedProject == null
              ? null
              : (val) => setState(() => _selectedTask = val),
      validator: (val) => val == null ? 'Please select a task' : null,
    );
  }
}
