import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_filters.dart';

class TodoEmptyState extends StatelessWidget {
  const TodoEmptyState({super.key, required this.message});
  final EmptyMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FontAwesomeIcons.inbox, size: 40, color: Color(0xFFD0DCE8)),
            const SizedBox(height: 14),
            Text(
              message.title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 15, color: TodoColors.textMuted),
            ),
            const SizedBox(height: 4),
            Text(
              message.subtitle,
              style: const TextStyle(fontSize: 12.5, color: TodoColors.textFaint),
            ),
          ],
        ),
      ),
    );
  }
}
