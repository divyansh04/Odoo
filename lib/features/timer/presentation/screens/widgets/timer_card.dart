import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:odoo/core/config/app_colors.dart';
import 'package:odoo/core/config/app_theme.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_event.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/timer_view.dart';

class TimerCard extends StatelessWidget {
  final TimerEntry timer;
  const TimerCard({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with date and start time
            Text(
              DateFormat('EEEE').format(DateTime.now()),
              style: AppTypography.textTheme.titleMedium,
            ),
            Text(
              DateFormat('dd.MM.yyyy').format(DateTime.now()),
              style: AppTypography.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              'Start Time 10:00',
              style: AppTypography.textTheme.bodySmall?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),

            // Middle section with timer and controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TimerView(
                  timer: timer,
                  style: AppTypography.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    // Stop Button
                    if (timer.isRunning)
                      GestureDetector(
                        onTap:
                            () => context.read<TimersBloc>().add(
                              StopTimer(timer.id, timer.description),
                            ),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.background.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.stop, color: Colors.white),
                        ),
                      ),
                    const SizedBox(width: 8),
                    // Play/Pause Button
                    GestureDetector(
                      onTap:
                          () => context.read<TimersBloc>().add(
                            TogglePlayPauseTimer(timer.id),
                          ),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          timer.isRunning ? Icons.pause : Icons.play_arrow,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text('Description', style: AppTypography.textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(
              timer.description.isEmpty
                  ? 'No description provided.'
                  : timer.description,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (timer.description.length > 80) // Show "Read More" for long text
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Read More',
                  style: AppTypography.textTheme.bodyMedium?.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  
  }
}