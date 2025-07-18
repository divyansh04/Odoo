import 'package:flutter/material.dart';
import 'package:odoo/core/config/app_colors.dart';
import 'package:odoo/core/config/app_theme.dart';
import 'package:odoo/features/timer/domain/entities/timer_entry.dart';

class DetailsTabView extends StatelessWidget {
  final TimerEntry timer;
  const DetailsTabView({super.key, required this.timer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildDetailCard('Project', timer.project.name),
          _buildDetailCard('Deadline', '10/11/2023'), // Static
          _buildDetailCard('Assigned to', 'Ivan Zhuikov'), // Static
          _buildDetailCard(
            'Description',
            'As a user, I would like to be able to buy a subscription, this would allow me to get a discount on the products and on the second stage of diagnosis', // Static
            isDescription: true,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
    String title,
    String value, {
    bool isDescription = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.textTheme.labelMedium?.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style:
                    isDescription
                        ? AppTypography.textTheme.bodyMedium
                        : AppTypography.textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
