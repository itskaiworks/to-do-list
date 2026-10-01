import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.title,
    required this.dueDate,
    this.description = '',
    this.isDone = false,
  });

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  bool isDone;
}
