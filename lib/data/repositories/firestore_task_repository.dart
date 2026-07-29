import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/task_entity.dart';
import 'package:taskflow_mobile/domain/repositories/task_repository.dart';

/// FirestoreTaskRepository - mirrors data/repositories/FirebaseTaskRepository.js
/// on the web app: setDoc with the client-generated UUID as the document
/// id (so add/update are both just a set), tasks scoped per signed-in user.
///
/// Tasks live under `users/{uid}/tasks/{taskId}` — a subcollection per
/// user, so queries never need a `where(userId == ...)` filter or an extra
/// Firestore index. If your existing web-app data instead lives in a flat
/// top-level `tasks` collection with a `userId` field, tell me and I'll
/// switch this to match exactly instead.
class FirestoreTaskRepository implements TaskRepository {
  FirestoreTaskRepository(this._firestore, this._auth);

  final FirebaseFirestore _firestore;
  final fb.FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _tasksCollection {
    final uid = _auth.currentUser?.uid;
    if (uid == null) {
      throw StateError('No signed-in user — cannot access tasks.');
    }
    return _firestore.collection('users').doc(uid).collection('tasks');
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    try {
      final snapshot = await _tasksCollection.get();
      final tasks = snapshot.docs.map((doc) => TaskEntity.fromJson(doc.data())).toList();
      return Right(tasks);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TaskEntity?>> getTask(String id) async {
    try {
      final doc = await _tasksCollection.doc(id).get();
      if (!doc.exists || doc.data() == null) return const Right(null);
      return Right(TaskEntity.fromJson(doc.data()!));
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getByStatus(bool completed) async {
    try {
      final snapshot = await _tasksCollection.where('completed', isEqualTo: completed).get();
      final tasks = snapshot.docs.map((doc) => TaskEntity.fromJson(doc.data())).toList();
      return Right(tasks);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> search(String query) async {
    // Firestore has no case-insensitive "contains" query — filtering by
    // search term is handled client-side in todo_filters.dart instead,
    // same as the rest of the app's nav/search filtering.
    return getAllTasks();
  }

  @override
  Future<Either<Failure, int>> count() async {
    try {
      final snapshot = await _tasksCollection.count().get();
      return Right(snapshot.count ?? 0);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addTask(TaskEntity task) async {
    try {
      await _tasksCollection.doc(task.id).set(task.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask(TaskEntity task) async {
    try {
      await _tasksCollection.doc(task.id).set(task.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeTask(TaskEntity task) async {
    try {
      await _tasksCollection.doc(task.id).delete();
      return const Right(null);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleComplete(TaskEntity task) => updateTask(task);

  @override
  Future<Either<Failure, void>> clearAll() async {
    try {
      final snapshot = await _tasksCollection.get();
      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      return const Right(null);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }
}
