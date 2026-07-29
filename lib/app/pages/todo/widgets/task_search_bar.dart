import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';

/// Mirrors TodoSearch.jsx / .search-row.
class TaskSearchBar extends StatefulWidget {
  const TaskSearchBar({
    super.key,
    required this.value,
    required this.placeholder,
    required this.onChanged,
    required this.showClearNav,
    required this.onClearNav,
  });

  final String value;
  final String placeholder;
  final void Function(String) onChanged;

  /// True when a nav filter other than "all" is active — shows the
  /// "back to all tasks" button, matching activeNav !== 'all' in JSX.
  final bool showClearNav;
  final VoidCallback onClearNav;

  @override
  State<TaskSearchBar> createState() => _TaskSearchBarState();
}

class _TaskSearchBarState extends State<TaskSearchBar> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(covariant TaskSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _controller.text && widget.value.isEmpty) {
      _controller.clear();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 16,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.magnifyingGlass, size: 14, color: TodoColors.textFaint),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              style: const TextStyle(fontSize: 14, color: TodoColors.textBody),
              decoration: InputDecoration(
                hintText: widget.placeholder,
                hintStyle: const TextStyle(color: TodoColors.textFaint),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          if (widget.value.isNotEmpty)
            _ClearButton(
              icon: FontAwesomeIcons.xmark,
              onTap: () {
                _controller.clear();
                widget.onChanged('');
              },
            ),
          if (widget.showClearNav)
            _ClearButton(icon: FontAwesomeIcons.house, onTap: widget.onClearNav),
        ],
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 13, color: TodoColors.textFaint),
        ),
      ),
    );
  }
}
