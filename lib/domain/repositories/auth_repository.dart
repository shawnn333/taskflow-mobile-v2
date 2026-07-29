import 'package:dartz/dartz.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/app_user.dart';

/// AuthRepository - mirrors IAuthRepository.js on the web app: login,
/// register, logout, plus a stream of auth state so the UI (AuthGate,
/// here the router guard) can react to sign-in/sign-out without polling.
abstract class AuthRepository {
  Future<Either<Failure, AppUser>> login({required String email, required String password});
  Future<Either<Failure, AppUser>> register({required String email, required String password});
  Future<Either<Failure, void>> logout();
  AppUser? get currentUser;
  Stream<AppUser?> get authStateChanges;
}
