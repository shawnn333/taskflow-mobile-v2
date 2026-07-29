import 'package:dartz/dartz.dart';
import 'package:taskflow_mobile/core/failure.dart';
import 'package:taskflow_mobile/domain/entities/app_user.dart';
import 'package:taskflow_mobile/domain/repositories/auth_repository.dart';

class LoginUseCase {
  LoginUseCase(this._repository);
  final AuthRepository _repository;

  Future<Either<Failure, AppUser>> execute({
    required String email,
    required String password,
  }) async {
    final trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty || !trimmedEmail.contains('@')) {
      return const Left(ErrorMessage(message: 'Please enter a valid email address'));
    }
    if (password.isEmpty) {
      return const Left(ErrorMessage(message: 'Please enter your password'));
    }
    return _repository.login(email: trimmedEmail, password: password);
  }
}
