part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    AppUser? user,
    AuthStatus? status,
  }) = _AuthState;
}

enum AuthStatus { success, error }
