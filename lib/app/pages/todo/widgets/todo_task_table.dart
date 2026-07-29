import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';
import 'package:taskflow_mobile/app/shared/dialogs.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';

bool _isFutureTask(DateTime createdAt) {
  final today = DateTime.now();
  final todayOnly = DateTime(today.year, today.month, today.day);
  final taskDateOnly = DateTime(createdAt.year, createdAt.month, createdAt.day);
  return taskDateOnly.isAfter(todayOnly);
}

/// Shared by any "mark as done" tap: asks for confirmation when the task is
/// due today or earlier, or shows an explanatory error when it's a
/// future-dated task — mirroring the same guard already enforced by
/// ToggleTaskCompletionUseCase, just surfaced before the round trip instead
/// of after a failed one.
Future<void> handleToggleTap(
  BuildContext context,
  TaskEntity task,
  VoidCallback onToggle,
) async {
  if (_isFutureTask(task.createdAt)) {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.circleExclamation, color: TodoColors.amber, size: 20),
            SizedBox(width: 10),
            Text('Not due yet'),
          ],
        ),
        content: Text(
          '"${task.title}" is scheduled for a future date. Tasks can only be marked '
          'done on or after the day they\'re due.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
    return;
  }

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(FontAwesomeIcons.circleCheck, color: TodoColors.green, size: 20),
          SizedBox(width: 10),
          Text('Mark as done?'),
        ],
      ),
      content: Text('Mark "${task.title}" as completed?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('Mark Done',
              style: TextStyle(color: TodoColors.green, fontWeight: FontWeight.w700)),
        ),
      ],
    ),
  );

  if (confirmed == true) {
    onToggle();
  }
}

/// Mirrors .todo-table: a header row (# / TASK / DATE / ACTIONS) followed by
/// one row per task, all inside a white rounded card.
class TodoTaskTable extends StatelessWidget {
  const TodoTaskTable({
    super.key,
    required this.tasks,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    this.showDateColumn = true,
  });

  final List<TaskEntity> tasks;
  final void Function(String id) onToggle;
  final void Function(String id) onDelete;
  final void Function(String id, String newTitle) onEdit;

  /// Mirrors `.todo-table th:nth-child(3) { display: none }` at the
  /// App.css 768px breakpoint — the DATE column is dropped on narrow
  /// widths so # / TASK / ACTIONS have more room.
  final bool showDateColumn;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 30,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        children: [
          _HeaderRow(showDateColumn: showDateColumn),
          for (var i = 0; i < tasks.length; i++)
            _TaskRow(
              index: i,
              task: tasks[i],
              isLast: i == tasks.length - 1,
              months: _months,
              showDateColumn: showDateColumn,
              onToggle: () => onToggle(tasks[i].id),
              onDelete: () => onDelete(tasks[i].id),
              onEdit: (title) => onEdit(tasks[i].id, title),
            ),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({required this.showDateColumn});
  final bool showDateColumn;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
      color: TodoColors.textMuted,
    );
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFE),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(bottom: BorderSide(color: Colors.black.withValues(alpha: 0.03))),
      ),
      child: Row(
        children: [
          const SizedBox(width: 32, child: Text('#', style: style)),
          const Expanded(flex: 3, child: Text('TASK', style: style)),
          if (showDateColumn)
            const SizedBox(width: 80, child: Text('DATE', style: style)),
          const SizedBox(width: 110, child: Text('ACTIONS', style: style, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}

class _TaskRow extends StatefulWidget {
  const _TaskRow({
    required this.index,
    required this.task,
    required this.isLast,
    required this.months,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    this.showDateColumn = true,
  });

  final int index;
  final TaskEntity task;
  final bool isLast;
  final List<String> months;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final void Function(String) onEdit;
  final bool showDateColumn;

  @override
  State<_TaskRow> createState() => _TaskRowState();
}

class _TaskRowState extends State<_TaskRow> {
  bool _editing = false;
  late final TextEditingController _controller =
      TextEditingController(text: widget.task.title);

  void _save() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && text != widget.task.title) {
      widget.onEdit(text);
      showCenteredSuccessDialog(context, message: 'Task updated successfully');
    }
    setState(() => _editing = false);
  }

  void _cancel() {
    _controller.text = widget.task.title;
    setState(() => _editing = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 16, 14),
      decoration: BoxDecoration(
        color: task.completed ? TodoColors.green.withValues(alpha: 0.02) : Colors.transparent,
        borderRadius: widget.isLast
            ? const BorderRadius.vertical(bottom: Radius.circular(24))
            : null,
        border: widget.isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.black.withValues(alpha: 0.02))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 32,
            child: Text('${widget.index + 1}',
                style: const TextStyle(color: TodoColors.textMuted, fontSize: 13)),
          ),
          Expanded(
            flex: 3,
            child: _editing
                ? Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: TodoColors.primary, width: 2),
                          ),
                          child: TextField(
                            controller: _controller,
                            autofocus: true,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, color: TodoColors.textBody, fontSize: 13),
                            decoration:
                                const InputDecoration(border: InputBorder.none, isDense: true),
                            onSubmitted: (_) => _save(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      _MiniIconButton(
                        icon: FontAwesomeIcons.check,
                        gradient: TodoColors.saveGradient,
                        onTap: _save,
                      ),
                      const SizedBox(width: 4),
                      _MiniIconButton(
                        icon: FontAwesomeIcons.xmark,
                        gradient: TodoColors.cancelGradient,
                        onTap: _cancel,
                      ),
                    ],
                  )
                : Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Text(
                        task.title.isEmpty ? 'Untitled Task' : task.title,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: task.completed ? TodoColors.textFaint : TodoColors.textBody,
                          decoration: task.completed ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      _StatusBadge(completed: task.completed),
                    ],
                  ),
          ),
          if (widget.showDateColumn)
            SizedBox(
              width: 80,
              child: Text(
                '${widget.months[task.createdAt.month - 1]} ${task.createdAt.day}',
                style: const TextStyle(fontSize: 12, color: TodoColors.textMuted),
              ),
            ),
          SizedBox(
            width: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                _RowActionButton(
                  icon: task.completed ? FontAwesomeIcons.solidCircleCheck : FontAwesomeIcons.circle,
                  color: TodoColors.green,
                  disabled: task.completed,
                  onTap: () => handleToggleTap(context, task, widget.onToggle),
                ),
                _RowActionButton(
                  icon: FontAwesomeIcons.pen,
                  color: TodoColors.primary,
                  onTap: () => setState(() => _editing = true),
                ),
                _RowActionButton(
                  icon: FontAwesomeIcons.trashCan,
                  color: TodoColors.red,
                  onTap: widget.onDelete,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.completed});
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final color = completed ? TodoColors.green : TodoColors.amber;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        completed ? '✓ DONE' : '⏳ PENDING',
        style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w700, color: color),
      ),
    );
  }
}

class _RowActionButton extends StatelessWidget {
  const _RowActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.disabled = false,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: disabled ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(icon, size: 14, color: disabled ? color.withValues(alpha: 0.5) : color),
        ),
      ),
    );
  }
}

class _MiniIconButton extends StatelessWidget {
  const _MiniIconButton({required this.icon, required this.gradient, required this.onTap});
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 11, color: Colors.white),
        ),
      ),
    );
  }
}
