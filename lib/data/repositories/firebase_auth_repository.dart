import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/app_user.dart';
import 'package:taskflow_mobile/domain/repositories/auth_repository.dart';

/// FirebaseAuthRepository - mirrors data/repositories/FirebaseAuthRepository.js
/// on the web app: thin wrapper over Firebase Auth's email/password sign-in.
class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth);
  final fb.FirebaseAuth _auth;

  AppUser _toAppUser(fb.User user) => AppUser(uid: user.uid, email: user.email);

  @override
  Future<Either<Failure, AppUser>> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      final user = credential.user;
      if (user == null) {
        return const Left(ErrorMessage(message: 'Login failed. Please try again.'));
      }
      return Right(_toAppUser(user));
    } on fb.FirebaseAuthException catch (e) {
      return Left(ErrorMessage(message: _messageFor(e)));
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppUser>> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = credential.user;
      if (user == null) {
        return const Left(ErrorMessage(message: 'Registration failed. Please try again.'));
      }
      final appUser = _toAppUser(user);
      // Registering also signs the new user in automatically (Firebase's
      // default behavior) — sign back out immediately so the flow is
      // register -> sign in explicitly, not register -> straight into the
      // dashboard.
      await _auth.signOut();
      return Right(appUser);
    } on fb.FirebaseAuthException catch (e) {
      return Left(ErrorMessage(message: _messageFor(e)));
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _auth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ErrorMessage(message: e.toString()));
    }
  }

  @override
  AppUser? get currentUser {
    final user = _auth.currentUser;
    return user == null ? null : _toAppUser(user);
  }

  @override
  Stream<AppUser?> get authStateChanges =>
      _auth.authStateChanges().map((user) => user == null ? null : _toAppUser(user));

  String _messageFor(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No account found with that email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'An account already exists with that email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'invalid-email':
        return 'That email address looks invalid.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return e.message ?? 'Something went wrong. Please try again.';
    }
  }
}
