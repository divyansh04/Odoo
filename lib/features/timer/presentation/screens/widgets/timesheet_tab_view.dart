import 'package:flutter/material.dart';
import 'package:odoo/core/config/app_theme.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/completed_record_item.dart';
import 'package:odoo/features/timer/presentation/screens/widgets/timer_card.dart';

class TimesheetsTabView extends StatelessWidget {
  final TimerEntry timer;
  const TimesheetsTabView({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TimerCard(timer: timer),
        const SizedBox(height: 24),
        Text('Completed Records', style: AppTypography.textTheme.titleMedium),
        const SizedBox(height: 12),
        ...timer.completedRecords.reversed.map(
          (record) => CompletedRecordItem(record: record),
        ),
      ],
    );
  }
}
