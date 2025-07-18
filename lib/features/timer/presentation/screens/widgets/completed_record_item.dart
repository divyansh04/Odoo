import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odoo/core/config/app_colors.dart';
import 'package:odoo/core/config/app_theme.dart';
import 'package:odoo/features/timer/domain/entities/completed_record.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/timer_view.dart';

class CompletedRecordItem extends StatelessWidget {
  final CompletedRecord record;
  const CompletedRecordItem({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final hasDescription = record.description.isNotEmpty;
    final durationString = TimerView.formatDuration(record.duration);

    if (!hasDescription) {
      return Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: const Icon(Icons.check_circle, color: AppColors.primary),
          title: Text(DateFormat('EEEE, dd.MM.yyyy').format(record.date)),
          subtitle: const Text('Start Time 10:00'), // Static
          trailing: Text(
            durationString,
            style: AppTypography.textTheme.titleMedium,
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: const Icon(Icons.check_circle, color: AppColors.primary),
        title: Text(DateFormat('EEEE, dd.MM.yyyy').format(record.date)),
        subtitle: const Text('Start Time 10:00'), // Static
        trailing: Text(
          durationString,
          style: AppTypography.textTheme.titleMedium,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: AppTypography.textTheme.labelMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(record.description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
