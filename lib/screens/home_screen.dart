import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../boxes.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';
import '../widgets/empty_state.dart';
import '../widgets/task_card.dart';
import 'task_form_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openTaskForm(BuildContext context, {Task? taskToEdit}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskFormScreen(taskToEdit: taskToEdit),
      ),
    );
  }

  void _deleteTask(BuildContext context, Task task) {
    final Task deletedCopy = Task(
      title: task.title,
      description: task.description,
      dueDate: task.dueDate,
      isDone: task.isDone,
    );
    task.delete();

    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text('"${deletedCopy.title}" deleted'),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: const Color(0xFFB8BEFF),
          onPressed: () => taskBox.add(deletedCopy),
        ),
      ),
    );
  }

  void _toggleDone(Task task, bool? newValue) {
    task.isDone = newValue ?? false;
    task.save();
  }

  List<Task> _sortTasks(Iterable<Task> tasks) {
    final List<Task> sortedTasks = tasks.toList();
    sortedTasks.sort((first, second) {
      if (first.isDone != second.isDone) {
        return first.isDone ? 1 : -1;
      }
      return first.dueDate.compareTo(second.dueDate);
    });
    return sortedTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.school_rounded),
            SizedBox(width: 10),
            Text('Study To-Do'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openTaskForm(context),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Task'),
      ),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: taskBox.listenable(),
        builder: (context, box, _) {
          final List<Task> tasks = _sortTasks(box.values);
          final int doneCount = tasks.where((task) => task.isDone).length;

          return Column(
            children: [
              _SummaryHeader(totalCount: tasks.length, doneCount: doneCount),
              Expanded(
                child: tasks.isEmpty
                    ? const EmptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final Task task = tasks[index];
                          return Dismissible(
                            key: ValueKey(task.key),
                            direction: DismissDirection.endToStart,
                            background: const _DeleteBackground(),
                            onDismissed: (_) => _deleteTask(context, task),
                            child: TaskCard(
                              task: task,
                              onTap: () =>
                                  _openTaskForm(context, taskToEdit: task),
                              onToggleDone: (newValue) =>
                                  _toggleDone(task, newValue),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({required this.totalCount, required this.doneCount});

  final int totalCount;
  final int doneCount;

  @override
  Widget build(BuildContext context) {
    final double progress = totalCount == 0 ? 0 : doneCount / totalCount;
    final String message = totalCount == 0
        ? 'Nothing planned yet'
        : '$doneCount of $totalCount tasks done';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 22),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.primaryDark,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeleteBackground extends StatelessWidget {
  const _DeleteBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.only(right: 24),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        color: AppColors.danger,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
      ),
      child: const Icon(Icons.delete_rounded, color: Colors.white, size: 28),
    );
  }
}
