import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.chipBackground,
              child: Icon(
                Icons.checklist_rounded,
                size: 48,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'No tasks yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Tap "Add Task" to write down your first assignment or reminder.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textMuted, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
