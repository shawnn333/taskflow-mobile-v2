import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';

/// Mirrors TodoInput.jsx / .input-row: rounded pill container, plus-circle
/// leading icon, quick-add Today/Tomorrow chips, gradient Add button.
///
/// Today/Tomorrow are a *selection*, not an immediate submit — tapping one
/// just picks which date the task will use (shown via the chip's active
/// state); the task is only actually created when Add is pressed (or Enter
/// is hit in the text field). Tapping a selected chip again deselects it,
/// which falls back to "today" as the default.
class TaskInputField extends StatefulWidget {
  const TaskInputField({
    super.key,
    required this.onAddTask,
    required this.onAddWithDate,
    this.singleRow = false,
  });

  final void Function(String title) onAddTask;
  final void Function(String title, int daysFromToday) onAddWithDate;

  /// When true, lays Today/Tomorrow/Add out inline with the text field on
  /// one row (matches the wide/desktop screenshot). When false (default),
  /// quick-add chips wrap to a second row — safer on a narrow phone width.
  final bool singleRow;

  @override
  State<TaskInputField> createState() => _TaskInputFieldState();
}

class _TaskInputFieldState extends State<TaskInputField> {
  final _controller = TextEditingController();

  /// null = no explicit pick (defaults to today), 0 = Today, 1 = Tomorrow.
  int? _selectedOffset;

  void _toggleOffset(int days) {
    setState(() => _selectedOffset = _selectedOffset == days ? null : days);
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    if (_selectedOffset != null) {
      widget.onAddWithDate(text, _selectedOffset!);
    } else {
      widget.onAddTask(text);
    }

    _controller.clear();
    setState(() => _selectedOffset = null);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 20,
              offset: const Offset(0, 4)),
        ],
      ),
      child: widget.singleRow ? _buildSingleRow() : _buildStacked(),
    );
  }

  Widget _buildSingleRow() {
    return Row(
      children: [
        const Icon(FontAwesomeIcons.circlePlus, size: 16, color: TodoColors.textFaint),
        const SizedBox(width: 10),
        Expanded(child: _textField('Enter task...')),
        const SizedBox(width: 8),
        _QuickAddChip(
          icon: FontAwesomeIcons.calendarDay,
          label: 'Today',
          isSelected: _selectedOffset == 0,
          onTap: () => _toggleOffset(0),
        ),
        const SizedBox(width: 6),
        _QuickAddChip(
          icon: FontAwesomeIcons.calendarPlus,
          label: 'Tomorrow',
          isSelected: _selectedOffset == 1,
          onTap: () => _toggleOffset(1),
        ),
        const SizedBox(width: 8),
        _AddButton(onTap: _submit),
      ],
    );
  }

  Widget _buildStacked() {
    return Column(
      children: [
        Row(
          children: [
            const Icon(FontAwesomeIcons.circlePlus, size: 16, color: TodoColors.textFaint),
            const SizedBox(width: 10),
            Expanded(child: _textField('Enter task...')),
            const SizedBox(width: 6),
            _AddButton(onTap: _submit),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _QuickAddChip(
              icon: FontAwesomeIcons.calendarDay,
              label: 'Today',
              isSelected: _selectedOffset == 0,
              onTap: () => _toggleOffset(0),
            ),
            const SizedBox(width: 6),
            _QuickAddChip(
              icon: FontAwesomeIcons.calendarPlus,
              label: 'Tomorrow',
              isSelected: _selectedOffset == 1,
              onTap: () => _toggleOffset(1),
            ),
            const SizedBox(width: 2),
          ],
        ),
      ],
    );
  }

  Widget _textField(String hint) {
    return TextField(
      controller: _controller,
      style: const TextStyle(fontWeight: FontWeight.w500, color: TodoColors.textBody),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: TodoColors.textFaint, fontWeight: FontWeight.w400),
        border: InputBorder.none,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      onSubmitted: (_) => _submit(),
      textInputAction: TextInputAction.done,
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            gradient: TodoColors.primaryGradient,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: TodoColors.primary.withValues(alpha: 0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4)),
            ],
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FontAwesomeIcons.circlePlus, size: 13, color: Colors.white),
              SizedBox(width: 6),
              Text('Add',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAddChip extends StatelessWidget {
  const _QuickAddChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            gradient: isSelected ? TodoColors.primaryGradient : null,
            color: isSelected ? null : TodoColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: isSelected
                ? null
                : Border.all(color: TodoColors.primary.withValues(alpha: 0.1)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 11, color: isSelected ? Colors.white : TodoColors.primary),
              const SizedBox(width: 5),
              Text(label,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : TodoColors.primary)),
            ],
          ),
        ),
      ),
    );
  }
}
