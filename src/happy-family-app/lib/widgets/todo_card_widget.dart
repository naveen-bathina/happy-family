import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertest/models/todo_item.dart';
import 'package:fluttertest/providers/todo_provider.dart';
import 'package:fluttertest/utils/formatters.dart';

class TodoCard extends ConsumerWidget {
  final TodoItem task;

  const TodoCard({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 1),
      title: Text(
        task.title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
          decoration:
              task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
        ),
      ),
      subtitle: Text(Formatters.formatDateTime(task.dueDate)),
      value: task.isCompleted,
      onChanged: (bool? value) {
        ref.read(todoProvider.notifier).toggleTodo(task);
      },
    );
  }
}
