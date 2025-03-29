part of 'auth_cubit.dart';

enum AuthStatus {
  initial,
  loading,
  success,
  error,
  getUserSuccess,
  getUserError
}

@immutable
class AuthState {
  final AuthStatus? status;
  final String? massage;
  final UserModel? currentUser;

  const AuthState({this.status, this.massage, this.currentUser});

  AuthState copyWith(
          {AuthStatus? status, String? massage, UserModel? currentUser}) =>
      AuthState(
          status: status ?? this.status,
          massage: massage ?? this.massage,
          currentUser: currentUser ?? this.currentUser);
}

final class AuthInitial extends AuthState {
  AuthInitial() : super(status: AuthStatus.initial);
}
