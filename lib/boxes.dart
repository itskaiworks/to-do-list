import 'package:hive/hive.dart';

import 'models/task.dart';

const String taskBoxName = 'todoTaskBox';

Box<Task> get taskBox => Hive.box<Task>(taskBoxName);
