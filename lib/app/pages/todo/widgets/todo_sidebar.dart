import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_filters.dart';
import 'package:taskflow_mobile/app/pages/todo/widgets/todo_header.dart';

/// Mirrors .sidebar from App.css / TodoSidebar.jsx: brand row up top, then a
/// vertical list of nav items with icon + label + badge, active item shown
/// with a light blue chip background, blue text, and a left accent bar.
///
/// Used in the wide/desktop layout (see todo_page.dart) — on a narrow phone
/// screen, TodoNavChips (horizontal scroll) is used instead since a fixed
/// 260px-wide column doesn't fit.
class TodoSidebarPanel extends StatelessWidget {
  const TodoSidebarPanel({
    super.key,
    required this.activeNav,
    required this.totalTasks,
    required this.upcomingCount,
    required this.onSelected,
  });

  final NavFilter activeNav;
  final int totalTasks;
  final int upcomingCount;
  final void Function(NavFilter) onSelected;

  @override
  Widget build(BuildContext context) {
    final items = <_SidebarItemData>[
      _SidebarItemData(NavFilter.all, FontAwesomeIcons.listUl, 'All Tasks', totalTasks),
      _SidebarItemData(NavFilter.today, FontAwesomeIcons.clock, 'Today', null),
      _SidebarItemData(
          NavFilter.upcoming, FontAwesomeIcons.calendarWeek, 'Upcoming', upcomingCount),
      _SidebarItemData(NavFilter.thisWeek, FontAwesomeIcons.calendarDays, 'This Week', null),
      _SidebarItemData(NavFilter.thisMonth, FontAwesomeIcons.calendar, 'This Month', null),
    ];

    return Container(
      width: 260,
      padding: const EdgeInsets.fromLTRB(22, 28, 18, 28),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.black.withValues(alpha: 0.03)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TodoBrand(),
          const SizedBox(height: 28),
          for (final item in items) ...[
            _SidebarNavItem(
              data: item,
              isActive: item.filter == activeNav,
              onTap: () => onSelected(item.filter),
            ),
            const SizedBox(height: 4),
          ],
        ],
      ),
    );
  }
}

class _SidebarItemData {
  const _SidebarItemData(this.filter, this.icon, this.label, this.badge);
  final NavFilter filter;
  final IconData icon;
  final String label;
  final int? badge;
}

class _SidebarNavItem extends StatelessWidget {
  const _SidebarNavItem({required this.data, required this.isActive, required this.onTap});

  final _SidebarItemData data;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            gradient: isActive
                ? LinearGradient(colors: [
                    TodoColors.primary.withValues(alpha: 0.1),
                    TodoColors.primaryLight.withValues(alpha: 0.04),
                  ])
                : null,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              if (isActive)
                Container(
                  width: 4,
                  height: 20,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    gradient: TodoColors.primaryGradient,
                    borderRadius: BorderRadius.circular(4),
                  ),
                )
              else
                const SizedBox(width: 14),
              Icon(data.icon,
                  size: 15, color: isActive ? TodoColors.primary : TodoColors.textMuted),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  data.label,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: isActive ? TodoColors.primary : TodoColors.textMuted,
                  ),
                ),
              ),
              if (data.badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${data.badge}',
                    style: const TextStyle(
                        fontSize: 10.5, fontWeight: FontWeight.w600, color: TodoColors.textMuted),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
