import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo/core/config/app_colors.dart';
import 'package:odoo/core/config/app_theme.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_state.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/details_tab_view.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/timesheet_tab_view.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/bakcground_gradient_container.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String timerId;
  const TaskDetailsScreen({super.key, required this.timerId});

  @override
  Widget build(BuildContext context) {
    return BackgroundGradientContainer(
      child: BlocBuilder<TimersBloc, TimersState>(
        builder: (context, state) {
          // Find the specific timer from the state
          final timer = state.timers.firstWhere(
            (t) => t.id == timerId,
            orElse: () => throw Exception('Timer not found!'),
          );

          return DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  timer.task.name,
                  style: AppTypography.textTheme.titleLarge,
                ),
                bottom: const TabBar(
                  indicatorColor: AppColors.onBackground,
                  tabs: [Tab(text: 'Timesheets'), Tab(text: 'Details')],
                ),
              ),
              body: TabBarView(
                children: [
                  TimesheetsTabView(timer: timer),
                  DetailsTabView(timer: timer),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
