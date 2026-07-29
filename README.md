# TaskFlow Mobile

Flutter port of the TaskFlow React CRUD app, built on the Flutter Bloc Clean
Architecture template Clapton gave you. Same layering rules as the web app:
domain has zero Flutter/data imports, repository mutations take the full
entity and return void, use cases own the business rules.

## Get it running

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

The `build_runner` step is required — it generates `todo_bloc.freezed.dart`
and `routes.gr.dart`, which aren't checked in (same as the template).

I don't have the Flutter SDK / pub.dev access in this sandbox, so this
project was hand-written to match the template's exact patterns but not
compiled here. Run the steps above and let me know what the analyzer/build
runner says if anything doesn't line up — happy to fix it.

## Design

The UI is ported from `crud/src/App.css` and the `TodoSidebar` / `TodoInput` /
`TodoSearch` / `TodoTable` / `TodoStats` components — same blue (`#1A4CFF`),
same gradient background, same pill-shaped inputs, status badges, and
gradient buttons. `todo_colors.dart` holds every color pulled straight from
`App.css`. Two differences, both because a phone isn't a desktop:

- The fixed 280px sidebar becomes a horizontally scrollable chip row
  (`todo_nav_chips.dart`) — same nav items, icons, and badges, just laid out
  for a narrow screen (this is actually what App.css's own `@media
  (max-width: 768px)` rule already does to the sidebar).
- The `<table>` becomes a card list (`task_card.dart`) — same status badge,
  date badge, and color-coded action buttons, since an HTML table doesn't
  fit a phone width.
- Icons use `font_awesome_flutter` (same Font Awesome icon set as the
  `fa-*` classes in the JSX) and the heading font uses `google_fonts`'
  Inter, matching the CSS's `font-family: 'Inter', ...`.

## How this maps to the React app

| React app (`crud/src/`) | Flutter app (`lib/`) | Notes |
| --- | --- | --- |
| `domain/entities/Task.js` | `domain/entities/task_entity.dart` | Same validation rules (non-empty id/title); immutable here instead of mutated in place |
| `domain/repositories/TaskRepository.ts` | `domain/repositories/task_repository.dart` | Same contract: mutations take the full entity, return void (`Either<Failure, void>`) |
| `domain/usecases/*TaskUseCase.js` | `domain/usecases/todo/*_usecase.dart` | Same rules ported 1:1, including the "can't complete a future-dated task" guard |
| `data/repositories/FirebaseTaskRepository.js` | `data/repositories/local_task_repository.dart` | **Different for now** — this one uses `SharedPreferences`, not Firebase (see below) |
| Redux `task.slice.js` | `app/pages/todo/bloc/` (Bloc + events/state/handlers) | Bloc events ≈ Redux actions, state ≈ slice state, handler extensions ≈ thunks |
| `TodoPage.jsx` + components | `app/pages/todo/todo_page.dart` + `widgets/` | Same CRUD flow: add, edit inline, delete with confirm, toggle complete, search |

## What's intentionally left out of this first pass

- **Firebase** — you said local storage first. Tasks persist via
  `SharedPreferences` on device (`data/datasource/task_local_datasource.dart`).
  Nothing above the data layer needs to change to swap this for Firebase —
  same as flipping `REACT_APP_TASK_REPOSITORY` on web. When you're ready:
  1. Add `cloud_firestore`/`firebase_auth`/`firebase_core` to `pubspec.yaml`
     and run `flutterfire configure` against the same Firebase project
     (`crud-todo-af63f`) the web app uses.
  2. Write a `FirebaseTaskDataSource` next to `TaskLocalDataSource`.
  3. Register it in `injection_container.dart` instead of
     `TaskLocalDataSourceImpl` (or add a `FirebaseTaskRepository`
     implementing the same `TaskRepository` interface).
  4. Nothing in `domain/` or `app/` changes.
- **Auth / login page** — same reasoning. `AuthGuard` in
  `core/autoroutes/authguard.dart` is stubbed and commented out, ready for
  when Firebase Auth comes in.
- **Date-range nav filters** (Today / Upcoming / This Week / This Month from
  the web sidebar) — only free-text search is wired up for this pass, to keep
  the first port reviewable. `GetAllTasksUseCase` already takes a
  `searchTerm`; adding a nav-style filter is a small follow-up in the same
  shape as `getAllTasksUseCase.js`.

## Tests

```bash
flutter test
```

- `test/domain/entities/task_entity_test.dart` — mirrors `Task.test.js`
- `test/domain/usecases/toggle_task_completion_usecase_test.dart` — covers
  the future-date guard using a fake in-memory repository (no plugin
  dependency needed for that test)

## Project structure

```
lib/
├── app/pages/todo/          # Presentation: page, widgets, bloc
│   ├── todo_page.dart
│   ├── widgets/
│   └── bloc/
│       ├── todo_bloc.dart
│       ├── todo_event.dart
│       ├── todo_state.dart
│       └── handlers/
├── core/                    # DI, failures, routing
├── data/                    # SharedPreferences data source + repository impl
└── domain/                  # Entity, repository contract, use cases
```
