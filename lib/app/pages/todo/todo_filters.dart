import 'package:taskflow_mobile/domain/entities/task_entity.dart';

/// Mirrors the `activeNav` values from the web app's task.slice.js /
/// TodoSidebar.jsx.
enum NavFilter { all, today, upcoming, thisWeek, thisMonth }

class EmptyMessage {
  const EmptyMessage(this.title, this.subtitle);
  final String title;
  final String subtitle;
}

/// Pure filtering/labeling logic ported from TodoPage.jsx's
/// getFilteredTasks / getUpcomingCount / getNavLabel / getEmptyMessage.
/// Kept as static helpers (not a use case) since, like the web app, this
/// operates on the already-fetched in-memory list rather than hitting the
/// repository again.
class TodoFilters {
  TodoFilters._();

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  static List<TaskEntity> apply({
    required List<TaskEntity> tasks,
    required NavFilter navFilter,
    required String searchQuery,
  }) {
    var filtered = List<TaskEntity>.from(tasks);

    final term = searchQuery.toLowerCase().trim();
    if (term.isNotEmpty) {
      filtered = filtered.where((t) => t.title.toLowerCase().contains(term)).toList();
    }

    final today = _dateOnly(DateTime.now());
    final nextWeek = today.add(const Duration(days: 7));
    final endOfMonth = DateTime(today.year, today.month + 1, 0);

    bool inRange(TaskEntity t, {required bool includeToday}) {
      final d = _dateOnly(t.createdAt);
      final lower = includeToday ? !d.isBefore(today) : d.isAfter(today);
      return lower && !d.isAfter(nextWeek);
    }

    switch (navFilter) {
      case NavFilter.today:
        filtered = filtered.where((t) => _dateOnly(t.createdAt) == today).toList();
        break;
      case NavFilter.upcoming:
        filtered = filtered.where((t) => inRange(t, includeToday: false)).toList();
        break;
      case NavFilter.thisWeek:
        filtered = filtered.where((t) => inRange(t, includeToday: true)).toList();
        break;
      case NavFilter.thisMonth:
        filtered = filtered.where((t) {
          final d = _dateOnly(t.createdAt);
          return !d.isBefore(today) && !d.isAfter(endOfMonth);
        }).toList();
        break;
      case NavFilter.all:
        break;
    }

    // Web app sorts by id descending (newest-first, since ids are
    // timestamp-based). We mirror that with createdAt descending.
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return filtered;
  }

  static int upcomingCount(List<TaskEntity> tasks) {
    final today = _dateOnly(DateTime.now());
    final nextWeek = today.add(const Duration(days: 7));
    return tasks.where((t) {
      final d = _dateOnly(t.createdAt);
      return d.isAfter(today) && !d.isAfter(nextWeek);
    }).length;
  }

  static String navLabel(NavFilter navFilter) {
    switch (navFilter) {
      case NavFilter.today:
        return 'Today';
      case NavFilter.upcoming:
        return 'Upcoming (7 Days)';
      case NavFilter.thisWeek:
        return 'This Week';
      case NavFilter.thisMonth:
        return 'This Month';
      case NavFilter.all:
        return 'All Tasks';
    }
  }

  static EmptyMessage emptyMessage(NavFilter navFilter) {
    switch (navFilter) {
      case NavFilter.today:
        return const EmptyMessage('No tasks for today', 'Add a task to get started!');
      case NavFilter.upcoming:
        return const EmptyMessage(
            'No upcoming tasks', 'Plan ahead by adding tasks for the future!');
      case NavFilter.thisWeek:
        return const EmptyMessage(
            'No tasks this week', 'Add some tasks for the week ahead!');
      case NavFilter.thisMonth:
        return const EmptyMessage(
            'No tasks this month', 'Plan your month by adding tasks!');
      case NavFilter.all:
        return const EmptyMessage('No tasks found', 'Add a new task to get started!');
    }
  }
}
