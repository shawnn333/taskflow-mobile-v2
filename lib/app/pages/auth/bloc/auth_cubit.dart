import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taskflow_mobile/core/injection_container.dart';
import 'package:taskflow_mobile/domain/entities/app_user.dart';
import 'package:taskflow_mobile/domain/usecases/auth/login_usecase.dart';
import 'package:taskflow_mobile/domain/usecases/auth/logout_usecase.dart';
import 'package:taskflow_mobile/domain/usecases/auth/register_usecase.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

/// AuthCubit - a plain Cubit rather than the event/handler Bloc pattern
/// used elsewhere (TodoBloc): login/register/logout are three independent
/// one-shot actions, not a continuous stream of related events reacting to
/// evolving state, so a Cubit's direct methods are a better fit here.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true, errorMessage: '', status: null));

    final result = await serviceLocator<LoginUseCase>().execute(
      email: email,
      password: password,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        status: AuthStatus.error,
        errorMessage: failure.message?.toString() ?? 'Login failed. Please try again.',
      )),
      (user) => emit(state.copyWith(
        isLoading: false,
        status: AuthStatus.success,
        user: user,
        errorMessage: '',
      )),
    );
  }

  Future<void> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: '', status: null));

    final result = await serviceLocator<RegisterUseCase>().execute(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        status: AuthStatus.error,
        errorMessage: failure.message?.toString() ?? 'Registration failed. Please try again.',
      )),
      (user) => emit(state.copyWith(
        isLoading: false,
        status: AuthStatus.success,
        user: user,
        errorMessage: '',
      )),
    );
  }

  Future<void> logout() async {
    await serviceLocator<LogoutUseCase>().execute();
    emit(const AuthState());
  }
}
