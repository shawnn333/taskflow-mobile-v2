import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:taskflow_mobile/app/pages/todo/bloc/todo_bloc.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_colors.dart';
import 'package:taskflow_mobile/app/pages/todo/todo_filters.dart';
import 'package:taskflow_mobile/app/pages/todo/widgets/task_input_field.dart';
import 'package:taskflow_mobile/app/pages/todo/widgets/task_search_bar.dart';
import 'package:taskflow_mobile/app/pages/todo/widgets/todo_empty_state.dart';
import 'package:taskflow_mobile/app/pages/todo/widgets/todo_header.dart';
import 'package:taskflow_mobile/app/pages/todo/widgets/todo_nav_chips.dart';
import 'package:taskflow_mobile/app/pages/todo/widgets/todo_sidebar.dart';
import 'package:taskflow_mobile/app/pages/todo/widgets/todo_task_table.dart';
import 'package:taskflow_mobile/core/autoroutes/routes.gr.dart';
import 'package:taskflow_mobile/core/injection_container.dart';
import 'package:taskflow_mobile/domain/usecases/auth/logout_usecase.dart';

/// Below this width there isn't room for a fixed 260px sidebar + a 4-column
/// table, so the layout falls back to the horizontal nav chips + stacked
/// task cards instead. Above it, the layout matches the web app's
/// sidebar + table screenshot.
const _wideLayoutBreakpoint = 760.0;

@RoutePage()
class TodoPage extends StatelessWidget {
  const TodoPage({super.key});
  static const route = '/todo';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc()..add(const TodoEvent.started()),
      child: const _TodoView(),
    );
  }
}

class _TodoView extends StatelessWidget {
  const _TodoView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Mirrors body { background: linear-gradient(...) } from App.css.
        decoration: const BoxDecoration(gradient: TodoColors.bodyGradient),
        child: SafeArea(
          child: BlocConsumer<TodoBloc, TodoState>(
            listener: (context, state) {
              if (state.status == TodoStatus.error && state.errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: TodoColors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    content: Text(state.errorMessage),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state.isLoading && state.tasks.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(color: TodoColors.primary),
                );
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= _wideLayoutBreakpoint;
                  return isWide ? _WideLayout(state: state) : _NarrowLayout(state: state);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

void _confirmDelete(BuildContext context, String id) {
  showDialog(
    context: context,
    builder: (dialogContext) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text('Delete this task?'),
      content: const Text('This action cannot be undone.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            context.read<TodoBloc>().add(TodoEvent.removeTask(id: id));
            Navigator.of(dialogContext).pop();
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(FontAwesomeIcons.trashCan, size: 13, color: TodoColors.red),
              SizedBox(width: 6),
              Text('Delete', style: TextStyle(color: TodoColors.red)),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Desktop/wide layout — a centered floating card with a left sidebar and
/// a 4-column task table, matching the web app 1:1 at desktop width.
class _WideLayout extends StatelessWidget {
  const _WideLayout({required this.state});
  final TodoState state;

  @override
  Widget build(BuildContext context) {
    final filtered = TodoFilters.apply(
      tasks: state.tasks,
      navFilter: state.activeNav,
      searchQuery: state.searchQuery,
    );
    final done = state.tasks.where((t) => t.completed).length;
    final navLabel = TodoFilters.navLabel(state.activeNav);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Fill the real viewport (minus a small margin) instead of capping
        // at a fixed height — matches the web app's card, which grows to
        // fill the browser window rather than stopping partway down it.
        const margin = 20.0;
        final cardWidth =
            (constraints.maxWidth - margin * 2).clamp(0, 1200).toDouble();
        final cardHeight = (constraints.maxHeight - margin * 2)
            .clamp(0, double.infinity)
            .toDouble();

        return Center(
          child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: Container(
              margin: const EdgeInsets.all(margin),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 60,
                      offset: const Offset(0, 20)),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TodoSidebarPanel(
                    activeNav: state.activeNav,
                    totalTasks: state.tasks.length,
                    upcomingCount: TodoFilters.upcomingCount(state.tasks),
                    onSelected: (nav) =>
                        context.read<TodoBloc>().add(TodoEvent.navChanged(nav: nav)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TodoHeaderRow(
                            label: navLabel,
                            done: done,
                            total: state.tasks.length,
                            trailing: const _LogoutButton(),
                          ),
                          const SizedBox(height: 20),
                          TaskInputField(
                            singleRow: true,
                            onAddTask: (title) => context
                                .read<TodoBloc>()
                                .add(TodoEvent.addTask(title: title, createdAt: DateTime.now())),
                            onAddWithDate: (title, days) {
                              final date = DateTime.now().add(Duration(days: days));
                              context.read<TodoBloc>().add(
                                    TodoEvent.addTask(
                                      title: title,
                                      createdAt: DateTime(date.year, date.month, date.day),
                                    ),
                                  );
                            },
                          ),
                          const SizedBox(height: 14),
                          TaskSearchBar(
                            value: state.searchQuery,
                            placeholder: 'Search ${navLabel.toLowerCase()}...',
                            onChanged: (value) =>
                                context.read<TodoBloc>().add(TodoEvent.searchChanged(query: value)),
                            showClearNav: state.activeNav != NavFilter.all,
                            onClearNav: () => context
                                .read<TodoBloc>()
                                .add(const TodoEvent.navChanged(nav: NavFilter.all)),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: filtered.isEmpty
                                ? SingleChildScrollView(
                                    child: TodoEmptyState(
                                      message: TodoFilters.emptyMessage(state.activeNav),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    child: TodoTaskTable(
                                      tasks: filtered,
                                      onToggle: (id) =>
                                          context.read<TodoBloc>().add(TodoEvent.toggleTask(id: id)),
                                      onDelete: (id) => _confirmDelete(context, id),
                                      onEdit: (id, title) => context
                                          .read<TodoBloc>()
                                          .add(TodoEvent.updateTask(id: id, title: title)),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Narrow/phone layout — mirrors App.css's own `@media (max-width: 768px)`
/// rules: the sidebar becomes a full-width wrapping row of pills (no
/// badges, active shown as a solid fill instead of an accent bar), and the
/// table drops its DATE column instead of switching to a different layout.
class _NarrowLayout extends StatelessWidget {
  const _NarrowLayout({required this.state});
  final TodoState state;

  @override
  Widget build(BuildContext context) {
    final filtered = TodoFilters.apply(
      tasks: state.tasks,
      navFilter: state.activeNav,
      searchQuery: state.searchQuery,
    );
    final done = state.tasks.where((t) => t.completed).length;
    final navLabel = TodoFilters.navLabel(state.activeNav);

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 40,
                offset: const Offset(0, 12)),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        TodoBrand(),
                        _LogoutButton(),
                      ],
                    ),
                    const SizedBox(height: 18),
                    TodoNavChips(
                      activeNav: state.activeNav,
                      onSelected: (nav) =>
                          context.read<TodoBloc>().add(TodoEvent.navChanged(nav: nav)),
                    ),
                    const SizedBox(height: 22),
                    TodoHeaderRow(label: navLabel, done: done, total: state.tasks.length),
                    const SizedBox(height: 16),
                    TaskInputField(
                      onAddTask: (title) => context
                          .read<TodoBloc>()
                          .add(TodoEvent.addTask(title: title, createdAt: DateTime.now())),
                      onAddWithDate: (title, days) {
                        final date = DateTime.now().add(Duration(days: days));
                        context.read<TodoBloc>().add(
                              TodoEvent.addTask(
                                title: title,
                                createdAt: DateTime(date.year, date.month, date.day),
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: 10),
                    TaskSearchBar(
                      value: state.searchQuery,
                      placeholder: 'Search ${navLabel.toLowerCase()}...',
                      onChanged: (value) =>
                          context.read<TodoBloc>().add(TodoEvent.searchChanged(query: value)),
                      showClearNav: state.activeNav != NavFilter.all,
                      onClearNav: () => context
                          .read<TodoBloc>()
                          .add(const TodoEvent.navChanged(nav: NavFilter.all)),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            if (filtered.isEmpty)
              SliverToBoxAdapter(
                child: TodoEmptyState(message: TodoFilters.emptyMessage(state.activeNav)),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                sliver: SliverToBoxAdapter(
                  child: TodoTaskTable(
                    tasks: filtered,
                    showDateColumn: false,
                    onToggle: (id) =>
                        context.read<TodoBloc>().add(TodoEvent.toggleTask(id: id)),
                    onDelete: (id) => _confirmDelete(context, id),
                    onEdit: (id, title) => context
                        .read<TodoBloc>()
                        .add(TodoEvent.updateTask(id: id, title: title)),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Small icon button used in both layouts — signs out via LogoutUseCase,
/// then sends the user back to LoginRoute (also happens automatically via
/// AuthGuard on next protected-route navigation, but doing it explicitly
/// here gives instant feedback instead of waiting for a stray navigation).
class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Log out?'),
        content: const Text('You\'ll need to sign in again to see your tasks.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Log Out', style: TextStyle(color: TodoColors.red)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    await serviceLocator<LogoutUseCase>().execute();
    if (!context.mounted) return;
    context.router.replaceAll([const LoginRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => _handleLogout(context),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: TodoColors.red.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: const Icon(FontAwesomeIcons.rightFromBracket,
              size: 15, color: TodoColors.red),
        ),
      ),
    );
  }
}
