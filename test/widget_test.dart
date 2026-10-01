import 'package:finals_lab2/models/task.dart';
import 'package:finals_lab2/utils/date_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final DateTime fixedToday = DateTime(2026, 10, 1, 15, 30);

  group('DateHelper', () {
    test('formats a date as "Mon D, YYYY"', () {
      expect(DateHelper.formatDate(DateTime(2026, 10, 1)), 'Oct 1, 2026');
    });

    test('describes today and tomorrow in words', () {
      expect(
        DateHelper.describeDate(DateTime(2026, 10, 1), now: fixedToday),
        'Today',
      );
      expect(
        DateHelper.describeDate(DateTime(2026, 10, 2), now: fixedToday),
        'Tomorrow',
      );
      expect(
        DateHelper.describeDate(DateTime(2026, 10, 9), now: fixedToday),
        'Oct 9, 2026',
      );
    });

    test('detects past dates but not today', () {
      expect(
        DateHelper.isPastDate(DateTime(2026, 9, 30), now: fixedToday),
        isTrue,
      );
      expect(
        DateHelper.isPastDate(DateTime(2026, 10, 1), now: fixedToday),
        isFalse,
      );
    });
  });

  group('Task', () {
    test('starts as not done with an empty description', () {
      final Task task = Task(title: 'Study', dueDate: DateTime(2026, 10, 5));
      expect(task.isDone, isFalse);
      expect(task.description, isEmpty);
    });
  });
}
