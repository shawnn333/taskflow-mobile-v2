import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:taskflow_mobile/data/repositories/firebase_auth_repository.dart';
import 'package:taskflow_mobile/data/repositories/firestore_task_repository.dart';
import 'package:taskflow_mobile/domain/repositories/auth_repository.dart';
import 'package:taskflow_mobile/domain/repositories/task_repository.dart';
import 'package:taskflow_mobile/domain/usecases/auth/login_usecase.dart';
import 'package:taskflow_mobile/domain/usecases/auth/logout_usecase.dart';
import 'package:taskflow_mobile/domain/usecases/auth/register_usecase.dart';
import 'package:taskflow_mobile/domain/usecases/todo/add_task_usecase.dart';
import 'package:taskflow_mobile/domain/usecases/todo/get_all_tasks_usecase.dart';
import 'package:taskflow_mobile/domain/usecases/todo/remove_task_usecase.dart';
import 'package:taskflow_mobile/domain/usecases/todo/toggle_task_completion_usecase.dart';
import 'package:taskflow_mobile/domain/usecases/todo/update_task_usecase.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // Firebase SDK instances
  serviceLocator.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Repositories
  // NOTE: this now talks to Firebase (Auth + Firestore) instead of
  // SharedPreferences. LocalTaskRepository/TaskLocalDataSource are still in
  // the project if you ever want to go back to offline-only storage — just
  // swap the registration below.
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => FirebaseAuthRepository(serviceLocator<FirebaseAuth>()),
  );
  serviceLocator.registerLazySingleton<TaskRepository>(
    () => FirestoreTaskRepository(
      serviceLocator<FirebaseFirestore>(),
      serviceLocator<FirebaseAuth>(),
    ),
  );

  // Auth use cases
  serviceLocator.registerFactory(
    () => LoginUseCase(serviceLocator<AuthRepository>()),
  );
  serviceLocator.registerFactory(
    () => RegisterUseCase(serviceLocator<AuthRepository>()),
  );
  serviceLocator.registerFactory(
    () => LogoutUseCase(serviceLocator<AuthRepository>()),
  );

  // Todo use cases
  serviceLocator.registerFactory(
    () => AddTaskUseCase(serviceLocator<TaskRepository>()),
  );
  serviceLocator.registerFactory(
    () => GetAllTasksUseCase(serviceLocator<TaskRepository>()),
  );
  serviceLocator.registerFactory(
    () => UpdateTaskUseCase(serviceLocator<TaskRepository>()),
  );
  serviceLocator.registerFactory(
    () => RemoveTaskUseCase(serviceLocator<TaskRepository>()),
  );
  serviceLocator.registerFactory(
    () => ToggleTaskCompletionUseCase(serviceLocator<TaskRepository>()),
  );
}
