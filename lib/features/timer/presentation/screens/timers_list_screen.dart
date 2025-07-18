import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo/core/config/app_theme.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_state.dart';
import 'package:odoo/features/timer/presentation/screens/create_timer_screen.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/bakcground_gradient_container.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/timer_list_item.dart';

class TimersListScreen extends StatelessWidget {
  const TimersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundGradientContainer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Timesheets'),
          actions: [
            IconButton(
              onPressed:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const CreateTimerScreen(),
                    ),
                  ),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: BlocBuilder<TimersBloc, TimersState>(
          builder: (context, state) {
            if (state.timersStatus == DataStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildTimerList(state.timers);
          },
        ),
      ),
    );
  }

  Widget _buildTimerList(List<TimerEntry> timers) {
    if (timers.isEmpty) {
      return Center(
        child: Text(
          'No timers found.',
          style: AppTypography.textTheme.bodyLarge,
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: timers.length,
      itemBuilder: (context, index) {
        final timer = timers[index];
        return TimerListItem(timer: timer);
      },
    );
  }
}
