import 'package:dartz/dartz.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/app_user.dart';
import 'package:taskflow_mobile/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  RegisterUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, AppUser>> execute({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty || !trimmedEmail.contains('@')) {
      return const Left(ErrorMessage(message: 'Please enter a valid email address'));
    }
    if (password.length < 6) {
      return const Left(ErrorMessage(message: 'Password must be at least 6 characters'));
    }
    if (password != confirmPassword) {
      return const Left(ErrorMessage(message: 'Passwords do not match'));
    }
    return _repository.register(email: trimmedEmail, password: password);
  }
}
