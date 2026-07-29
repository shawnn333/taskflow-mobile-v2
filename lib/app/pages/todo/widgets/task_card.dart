import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';

/// Mirrors a row of .todo-table (adapted into a card, since an HTML table
/// doesn't translate to a phone width): task text + status badge + date
/// badge, action buttons (mark/edit/delete), and inline edit mode.
class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  final TaskEntity task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final void Function(String newTitle) onEdit;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _editing = false;
  late final TextEditingController _controller =
      TextEditingController(text: widget.task.title);

  void _save() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && text != widget.task.title) {
      widget.onEdit(text);
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
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 12),
      decoration: BoxDecoration(
        color: task.completed
            ? TodoColors.green.withValues(alpha: 0.02)
            : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.03)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 16,
              offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _editing ? _buildEditRow() : _buildTitleRow(task),
          const SizedBox(height: 10),
          Row(
            children: [
              _DateBadge(date: task.createdAt),
              const Spacer(),
              _ActionButton(
                icon: task.completed
                    ? FontAwesomeIcons.solidCircleCheck
                    : FontAwesomeIcons.circle,
                label: task.completed ? 'Done' : 'Mark',
                color: TodoColors.green,
                disabled: task.completed,
                onTap: widget.onToggle,
              ),
              _ActionButton(
                icon: _editing ? FontAwesomeIcons.floppyDisk : FontAwesomeIcons.pen,
                label: _editing ? 'Save' : 'Edit',
                color: TodoColors.primary,
                onTap: _editing ? _save : () => setState(() => _editing = true),
              ),
              _ActionButton(
                icon: FontAwesomeIcons.trashCan,
                label: 'Delete',
                color: TodoColors.red,
                onTap: widget.onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitleRow(TaskEntity task) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 4,
      children: [
        Text(
          task.title.isEmpty ? 'Untitled Task' : task.title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: task.completed ? TodoColors.textFaint : TodoColors.textBody,
            decoration: task.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        _StatusBadge(completed: task.completed),
      ],
    );
  }

  Widget _buildEditRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: TodoColors.primary, width: 2),
            ),
            child: TextField(
              controller: _controller,
              autofocus: true,
              style: const TextStyle(fontWeight: FontWeight.w500, color: TodoColors.textBody),
              decoration: const InputDecoration(border: InputBorder.none, isDense: true),
              onSubmitted: (_) => _save(),
            ),
          ),
        ),
        const SizedBox(width: 6),
        _EditIconButton(
          icon: FontAwesomeIcons.check,
          gradient: TodoColors.saveGradient,
          onTap: _save,
        ),
        const SizedBox(width: 4),
        _EditIconButton(
          icon: FontAwesomeIcons.xmark,
          gradient: TodoColors.cancelGradient,
          onTap: _cancel,
        ),
      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        completed ? '✓ DONE' : '⏳ PENDING',
        style: TextStyle(
            fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 0.4, color: color),
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.date});
  final DateTime date;

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F4FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(FontAwesomeIcons.solidCalendar, size: 9, color: TodoColors.primary),
          const SizedBox(width: 5),
          Text(
            '${_months[date.month - 1]} ${date.day}',
            style: const TextStyle(fontSize: 10.5, color: TodoColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.disabled = false,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: disabled ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Icon(icon, size: 16, color: disabled ? color.withValues(alpha: 0.5) : color),
        ),
      ),
    );
  }
}

class _EditIconButton extends StatelessWidget {
  const _EditIconButton({required this.icon, required this.gradient, required this.onTap});
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(9),
          decoration: BoxDecoration(gradient: gradient, borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, size: 13, color: Colors.white),
        ),
      ),
    );
  }
}
