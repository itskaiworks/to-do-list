import 'package:flutter/material.dart';

import '../boxes.dart';
import '../models/task.dart';
import '../theme/app_theme.dart';
import '../utils/date_helper.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key, this.taskToEdit});

  final Task? taskToEdit;

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late DateTime _selectedDate;

  bool get _isEditing => widget.taskToEdit != null;

  @override
  void initState() {
    super.initState();
    final Task? existingTask = widget.taskToEdit;
    if (existingTask != null) {
      _titleController.text = existingTask.title;
      _descriptionController.text = existingTask.description;
      _selectedDate = existingTask.dueDate;
    } else {
      _selectedDate = DateHelper.dateOnly(DateTime.now());
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  void _saveTask() {
    if (!_formKey.currentState!.validate()) return;

    final String title = _titleController.text.trim();
    final String description = _descriptionController.text.trim();

    if (_isEditing) {
      final Task task = widget.taskToEdit!;
      task.title = title;
      task.description = description;
      task.dueDate = _selectedDate;
      task.save();
    } else {
      taskBox.add(
        Task(title: title, description: description, dueDate: _selectedDate),
      );
    }

    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(content: Text(_isEditing ? 'Task updated' : 'Task added')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit Task' : 'New Task')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FieldLabel('Title'),
                TextFormField(
                  controller: _titleController,
                  textCapitalization: TextCapitalization.sentences,
                  maxLength: 60,
                  decoration: const InputDecoration(
                    hintText: 'e.g. Finish Flutter lab',
                    prefixIcon: Icon(Icons.title_rounded),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a task title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                const _FieldLabel('Due date'),
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(12),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.event_rounded),
                      suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                    ),
                    child: Text(
                      DateHelper.formatDate(_selectedDate),
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const _FieldLabel('Notes (optional)'),
                TextFormField(
                  controller: _descriptionController,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 3,
                  maxLength: 200,
                  decoration: const InputDecoration(
                    hintText: 'Add any details you want to remember',
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _saveTask,
                  icon: Icon(
                    _isEditing ? Icons.check_rounded : Icons.add_task_rounded,
                  ),
                  label: Text(_isEditing ? 'Save Changes' : 'Add Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
