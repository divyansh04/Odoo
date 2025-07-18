import 'package:flutter/material.dart';
import 'package:odoo/core/config/app_colors.dart';

class BackgroundGradientContainer extends StatelessWidget {
  final Widget child;

  const BackgroundGradientContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.background, AppColors.surface],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
