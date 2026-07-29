import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_filters.dart';

/// Mirrors .sidebar at the App.css `@media (max-width: 768px)` breakpoint:
/// the sidebar becomes a full-width row that wraps onto multiple lines
/// (flex-wrap: wrap), badges are hidden (.nav-badge { display: none }),
/// and the active item is shown as a solid filled pill instead of a left
/// accent bar (.nav-item.active::before { display: none }).
class TodoNavChips extends StatelessWidget {
  const TodoNavChips({
    super.key,
    required this.activeNav,
    required this.onSelected,
  });

  final NavFilter activeNav;
  final void Function(NavFilter) onSelected;

  @override
  Widget build(BuildContext context) {
    const items = <_NavChipData>[
      _NavChipData(NavFilter.all, FontAwesomeIcons.listUl, 'All Tasks'),
      _NavChipData(NavFilter.today, FontAwesomeIcons.clock, 'Today'),
      _NavChipData(NavFilter.upcoming, FontAwesomeIcons.calendarWeek, 'Upcoming'),
      _NavChipData(NavFilter.thisWeek, FontAwesomeIcons.calendarDays, 'This Week'),
      _NavChipData(NavFilter.thisMonth, FontAwesomeIcons.calendar, 'This Month'),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final item in items)
          _NavChip(
            data: item,
            isActive: item.filter == activeNav,
            onTap: () => onSelected(item.filter),
          ),
      ],
    );
  }
}

class _NavChipData {
  const _NavChipData(this.filter, this.icon, this.label);
  final NavFilter filter;
  final IconData icon;
  final String label;
}

class _NavChip extends StatelessWidget {
  const _NavChip({required this.data, required this.isActive, required this.onTap});

  final _NavChipData data;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            gradient: isActive ? TodoColors.primaryGradient : null,
            color: isActive ? null : const Color(0xFFF3F5FB),
            borderRadius: BorderRadius.circular(24),
            boxShadow: isActive
                ? [
                    BoxShadow(
                        color: TodoColors.primary.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4)),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(data.icon, size: 13, color: isActive ? Colors.white : TodoColors.textMuted),
              const SizedBox(width: 7),
              Text(
                data.label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.white : TodoColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
