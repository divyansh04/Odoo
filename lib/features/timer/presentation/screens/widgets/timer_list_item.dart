import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo/core/config/app_colors.dart';
import 'package:odoo/core/config/app_theme.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_bloc.dart';
import 'package:odoo/features/timer/presentation/bloc/timer_event.dart';
import 'package:odoo/features/timer/presentation/screens/task_details_screen.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/timer_view.dart';

class TimerListItem extends StatelessWidget {
  final TimerEntry timer;
  const TimerListItem({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => TaskDetailsScreen(timerId: timer.id),
            ),
          ),
      child: Card(
        color: AppColors.surface,
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: [
              Container(
                width: 2.5,
                height: 65, 
                decoration: BoxDecoration(
                  color: AppColors.favoriteStar,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 16),
              // Expanded column for all the text info.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildInfoRow(
                      icon: timer.isFavorite ? Icons.star : Icons.star_border,
                      iconColor:
                          timer.isFavorite
                              ? AppColors.favoriteStar
                              : Colors.white,
                      text: timer.task.name,
                      style: AppTypography.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow(
                      icon: Icons.cases_outlined,
                      text: 'SO056 - ${timer.project.name}',
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildInfoRow(
                      icon: Icons.calendar_today_outlined,
                      text: 'Deadline 07/20/2025',
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Timer controls on the far right.
              _buildTimerControls(context),
            ],
          ),
        ),
      ),
    );
  }

  /// A flexible helper widget to build a row with an icon and text content.
  Widget _buildInfoRow({
    required IconData icon,
    required String text,
    Color? iconColor,
    TextStyle? style,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: iconColor ?? AppColors.onSurfaceVariant),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: style,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  /// Builds the timer controls with the duration and play/pause button.
  Widget _buildTimerControls(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 4.0),
            child: TimerView(
              timer: timer,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // A simple visual divider.
          const Text(
            '|',
            style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 18),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            color: Colors.black,
            icon: Icon(timer.isRunning ? Icons.pause : Icons.play_arrow),
            onPressed:
                () => context.read<TimersBloc>().add(
                  TogglePlayPauseTimer(timer.id),
                ),
          ),
        ],
      ),
    );
  }
}
