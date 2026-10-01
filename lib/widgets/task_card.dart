import 'package:flutter/material.dart';

import '../models/task.dart';
import '../theme/app_theme.dart';
import '../utils/date_helper.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onToggleDone,
  });

  final Task task;
  final VoidCallback onTap;
  final ValueChanged<bool?> onToggleDone;

  @override
  Widget build(BuildContext context) {
    final bool isOverdue = !task.isDone && DateHelper.isPastDate(task.dueDate);
    final Color dateColor = isOverdue ? AppColors.danger : AppColors.primary;
    final Color dateBackground =
        isOverdue ? AppColors.dangerSoft : AppColors.chipBackground;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        side: const BorderSide(color: Color(0xFFE3E5F5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 16, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: onToggleDone,
                activeColor: AppColors.success,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: task.isDone
                              ? AppColors.textMuted
                              : AppColors.textDark,
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    ),
                    if (task.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        task.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textMuted,
                          height: 1.3,
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: dateBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.event_rounded,
                            size: 15,
                            color: dateColor,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            isOverdue
                                ? 'Overdue · ${DateHelper.formatDate(task.dueDate)}'
                                : DateHelper.describeDate(task.dueDate),
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: dateColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
